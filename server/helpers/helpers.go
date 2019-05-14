package helpers

import (
	"fmt"
	"math"
	"reflect"
	"strconv"
	"time"

	"github.com/alexdor/sleep_well/server/client"
	"github.com/alexdor/sleep_well/server/influx"
)

var floatType = reflect.TypeOf(float64(0))
var stringType = reflect.TypeOf("")

func GetFloat(unk interface{}) (float64, error) {
	switch i := unk.(type) {
	case nil:
		return 0, nil
	case float64:
		return i, nil
	case float32:
		return float64(i), nil
	case int64:
		return float64(i), nil
	case int32:
		return float64(i), nil
	case int:
		return float64(i), nil
	case uint64:
		return float64(i), nil
	case uint32:
		return float64(i), nil
	case uint:
		return float64(i), nil
	case string:
		return strconv.ParseFloat(i, 64)
	default:
		v := reflect.ValueOf(unk)
		v = reflect.Indirect(v)
		if v.Type().ConvertibleTo(floatType) {
			fv := v.Convert(floatType)
			return fv.Float(), nil
		} else if v.Type().ConvertibleTo(stringType) {
			sv := v.Convert(stringType)
			s := sv.String()
			return strconv.ParseFloat(s, 64)
		} else {
			return math.NaN(), fmt.Errorf("Can't convert %v to float64", v.Type())
		}
	}
}

func ParseInfluxData(res *client.Response) []influx.InfluxData {
	data := []influx.InfluxData{}
	var err error
	for i := range res.Results {
		for _, val := range res.Results[i].Series {
			for y := range val.Values {
				tmp := influx.InfluxData{}
				for j := range val.Values[y] {
					switch j {
					case 0:
						t, ok := val.Values[y][j].(string)
						if !ok {
							fmt.Println(val.Values[y][j])
							continue
						}
						tmp.Timestamp, err = time.Parse(time.RFC3339, t)
						if err != nil {
							fmt.Println(err)
							continue
						}

					case 1:
						tmp.Humidity, err = GetFloat(val.Values[y][j])
						if err != nil {
							fmt.Println(err)
							continue
						}

					case 2:
						tmp.Temp, err = GetFloat(val.Values[y][j])
						if err != nil {
							fmt.Println(err)
							continue
						}

					}
				}
				data = append(data, tmp)
				break
			}
		}
	}
	return data
}

type AggrRes struct {
	Timestamp time.Time
	Value     float64
}

func ParseInfluxDataFromAggr(res *client.Response) []AggrRes {
	data := []AggrRes{}
	var err error
	for i := range res.Results {
		for _, val := range res.Results[i].Series {
			for y := range val.Values {
				tmp := AggrRes{}
				for j := range val.Values[y] {
					switch j {
					case 0:
						t, ok := val.Values[y][j].(string)
						if !ok {
							fmt.Println(val.Values[y][j])
							continue
						}
						tmp.Timestamp, err = time.Parse(time.RFC3339, t)
						if err != nil {
							fmt.Println(err)
							continue
						}

					case 1:
						tmp.Value, err = GetFloat(val.Values[y][j])
						if err != nil {
							fmt.Println(err)
							continue
						}
					}
				}
				data = append(data, tmp)
			}
		}
	}
	return data
}
