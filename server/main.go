package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"strings"
	"time"

	"github.com/NYTimes/gziphandler"
	"github.com/alexdor/sleep_well/server/helpers"
	"github.com/alexdor/sleep_well/server/influx"
	"github.com/jinzhu/now"
	"github.com/julienschmidt/httprouter"
	"github.com/rs/cors"
)

type ErrorRes struct {
	Err string `json:"err"`
}
type SuccessRes struct {
	Data string `json:"data"`
}

func main() {
	if strings.ToLower(os.Getenv("SEED")) == "true" {
		go seed()
	}
	router := httprouter.New()
	router.GET("/data", Index)
	router.GET("/duration", GetDuration)
	router.POST("/esp", HandleNewData)
	corsHandler := cors.Default().Handler(router)
	log.Fatal(http.ListenAndServe("0.0.0.0:8000", gziphandler.GzipHandler(corsHandler)))
}

func GetDuration(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	w.Header().Set("Content-Type", "application/json")
	// TODO: Parse actual date
	queryValues := r.URL.Query()

	isMonth := queryValues.Get("type") == "month"

	var end, start time.Time
	if isMonth {
		end = now.EndOfMonth()
		start = now.BeginningOfMonth()
	} else {
		end = now.EndOfWeek()
		start = now.BeginningOfWeek()
	}

	resTemp, err := influx.GetDateForRange(&start, &end, "temp", isMonth)
	if err != nil || resTemp.Error() != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		if err != nil {
			fmt.Println(err)
			err = json.NewEncoder(w).Encode(ErrorRes{Err: err.Error()})
		} else {
			fmt.Println(resTemp.Error())
			err = json.NewEncoder(w).Encode(ErrorRes{Err: resTemp.Err})
		}
		if err != nil {
			fmt.Println(err)
		}
		return
	}

	dataTemp := helpers.ParseInfluxDataFromAggr(resTemp)
	resHum, err := influx.GetDateForRange(&start, &end, "humidity", isMonth)
	if err != nil || resHum.Error() != nil {
		w.WriteHeader(http.StatusUnprocessableEntity)
		if err != nil {
			fmt.Println(err)
			err = json.NewEncoder(w).Encode(ErrorRes{Err: err.Error()})
		} else {
			fmt.Println(resHum.Error())
			err = json.NewEncoder(w).Encode(ErrorRes{Err: resHum.Err})
		}
		if err != nil {
			fmt.Println(err)
		}
		return
	}

	dataHum := helpers.ParseInfluxDataFromAggr(resHum)

	data := []influx.InfluxData{}
	for i := range dataTemp {
		data = append(data, influx.InfluxData{
			Timestamp: dataTemp[i].Timestamp,
			Temp:      dataTemp[i].Value,
			Humidity:  dataHum[i].Value,
		})
	}
	w.WriteHeader(http.StatusOK)
	err = json.NewEncoder(w).Encode(data)
	if err != nil {
		fmt.Println(err)
	}
}

func Index(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	w.Header().Set("Content-Type", "application/json")
	res, err := influx.GetData()
	if err != nil || res.Error() != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusUnprocessableEntity)
		err = json.NewEncoder(w).Encode(ErrorRes{Err: err.Error()})
		if err != nil {
			fmt.Println(err)
		}
		return
	}
	w.WriteHeader(http.StatusOK)

	data := helpers.ParseInfluxData(res)
	if len(data) > 0 {
		err = json.NewEncoder(w).Encode(data[0])
	} else {
		err = json.NewEncoder(w).Encode(nil)
	}
	if err != nil {
		fmt.Println(err)
	}

}

func HandleNewData(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
	w.Header().Set("Content-Type", "application/json")

	data := &influx.Data{}

	err := json.NewDecoder(r.Body).Decode(data)
	if err != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusUnprocessableEntity)
		err = json.NewEncoder(w).Encode(ErrorRes{Err: err.Error()})
		if err != nil {
			fmt.Println(err)
		}
		return
	}

	err = influx.SaveData(data, time.Now())
	if err != nil {
		fmt.Println(err)
		w.WriteHeader(http.StatusUnprocessableEntity)
		err = json.NewEncoder(w).Encode(ErrorRes{Err: err.Error()})
		if err != nil {
			fmt.Println(err)
		}
		return
	}
	w.WriteHeader(http.StatusCreated)
	err = json.NewEncoder(w).Encode(SuccessRes{})
	if err != nil {
		fmt.Println(err)
	}
}
