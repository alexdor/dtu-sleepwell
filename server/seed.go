package main

import (
	"fmt"
	"math/rand"
	"time"

	"github.com/alexdor/sleep_well/server/influx"
)

func seed() {
	unix := time.Now().Unix()
	for index := 0; index < 25920; index++ {
		t := time.Unix(unix-(5*60*int64(index)), 0)

		data := &influx.Data{Humidity: getRand(35, 42), Temp: getRand(16, 22), HeatIndex: getRand(10, 20)}
		err := influx.SaveData(data, t)
		if err != nil {
			fmt.Println(err)
		}
	}
}

func getRand(min, max int) float64 {
	rand.Seed(time.Now().UnixNano())
	return float64(rand.Intn(max-min)+min) + rand.Float64()

}
