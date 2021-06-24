package models

import (
	"context"
	"github.com/go-redis/redis/v8"
	_ "github.com/go-redis/redis/v8"
	"sort"
	"strconv"
)

var ctx = context.Background()
var rdb = redis.NewClient(&redis.Options{
	Addr:     "localhost:6379",
	Password: "",
	DB:       0,
})

type Datapoint struct {
	Y     int64  `json:"y"`
	Label string `json:"label"`
}

func SaveShots(groupname string, shotcount int) {
	keyExist := rdb.Exists(ctx, groupname)
	count := shotcount

	if keyExist.Val() == 1 {
		oldval, _ := strconv.ParseInt(rdb.Get(ctx, groupname).Val(), 10, 0)

		count = shotcount + int(oldval)
	}

	if count < 1 {
		rdb.Del(ctx, groupname)
	} else {
		rdb.Set(ctx, groupname, count, 0).Err()
	}

}

func GetGroupnames() ([]string, error) {
	keys := rdb.Keys(ctx, "*")
	return keys.Result()
}

func GetTotal() int {
	keys := rdb.Keys(ctx, "*")
	res, _ := keys.Result()

	total := 0

	for _, key := range res {
		value, _ := rdb.Get(ctx, key).Result()
		val, _ := strconv.ParseInt(value, 10, 0)

		total += int(val)
	}
	return total
}

func GetShotdata() []Datapoint {

	keys := rdb.Keys(ctx, "*")
	res, _ := keys.Result()

	var datapoints []Datapoint

	for _, key := range res {
		value, _ := rdb.Get(ctx, key).Result()
		val, _ := strconv.ParseInt(value, 10, 0)
		datapoints = append(datapoints, Datapoint{Y: val, Label: key})
	}

	sort.Slice(datapoints[:], func(i, j int) bool {
		return datapoints[i].Y > datapoints[j].Y
	})

	return datapoints
}
