package influx

import (
	"fmt"
	"os"
	"time"

	"github.com/alexdor/sleep_well/server/client"
)

var addr = "http://localhost:8086"

const database = "sleep_well"

func init() {
	endpoint := os.Getenv("INFLUXDB_ENDPOINT")
	if len(endpoint) > 0 {
		addr = endpoint
	}
}

func influxDBClient() (client.Client, error) {
	return client.NewHTTPClient(client.HTTPConfig{
		// Addr: "http://influxdb:8086",
		Addr: addr,
		// Username: username,
		// Password: password,
	})
}

type Data struct {
	Humidity  float64 `json:"humidity"`
	Temp      float64 `json:"temp"`
	HeatIndex float64 `json:"heatIndex"`
}

type InfluxData struct {
	Timestamp time.Time `json:"timestamp"`
	Humidity  float64   `json:"humidity"`
	Temp      float64   `json:"temp"`
}

var tags = map[string]string{"userID": "1"}

func GetData() (*client.Response, error) {
	c, err := influxDBClient()
	if err != nil {
		fmt.Println("Error creating InfluxDB Client: ", err.Error())
		return nil, err
	}
	defer c.Close()

	q := client.NewQuery("SELECT humidity, temp FROM heat_temp ORDER BY time DESC LIMIT 1", database, "")

	return c.Query(q)
}

func GetDateForRange(start, end *time.Time, field string, isMonth bool) (*client.Response, error) {
	c, err := influxDBClient()
	if err != nil {
		fmt.Println("Error creating InfluxDB Client: ", err.Error())
		return nil, err
	}
	defer c.Close()
	q := client.NewQuery(getQuery(field, start, end, isMonth), database, "")

	return c.Query(q)
	// if err != nil || temp.Error() != nil {
	// 	if err != nil {
	// 		return nil, err
	// 	}
	// 	return nil, temp.Error()
	// }

	// for _, t := range temp.Results {
	// 	for _, s := range t.Series {
	// 		s.Values
	// 	}
	// }
}

func getQuery(field string, start, end *time.Time, isMonth bool) string {
	if start == nil && end == nil {
		return ""
	}
	where := " WHERE "
	if start != nil {
		where += "time > '" + start.Format(time.RFC3339) + "' "
	}
	if start != nil && end != nil {
		where += " AND "
	}
	if end != nil {
		where += "time < '" + end.Format(time.RFC3339) + "' "
	}

	res := "SELECT first(mean) FROM (SELECT mean(" + field + ") FROM heat_temp" + where + " GROUP BY time(8h) )" + where + " GROUP BY time(24h,21h)"
	if !isMonth {
		return res
	}
	return "SELECT first(*) FROM (" + res + ") " + where + " GROUP BY time(1w)"
}

func SaveData(d *Data, t time.Time) error {
	c, err := influxDBClient()
	if err != nil {
		fmt.Println("Error creating InfluxDB Client: ", err.Error())
		return err
	}
	defer c.Close()
	bp, err := client.NewBatchPoints(client.BatchPointsConfig{
		Database:  database,
		Precision: "s",
	})

	if err != nil {
		fmt.Println("Error creating batchpoint: ", err.Error())
		return err
	}

	fields := map[string]interface{}{
		"humidity":   d.Humidity,
		"heat_index": d.HeatIndex,
		"temp":       d.Temp,
	}

	p, err := client.NewPoint("heat_temp", tags, fields, t)
	if err != nil {
		return err
	}

	bp.AddPoint(p)

	err = c.Write(bp)

	if err != nil {
		// if err != nil {
		fmt.Println(err)
		return err
		// }
		// fmt.Println(response.Error())
		// return response.Error()
	}
	return nil
}
