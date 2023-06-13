package fractal

import "encoding/json"

type item[T any] struct {
	Object     string `json:"object"`
	Attributes T      `json:"attributes"`
}

// TODO: deserialize functions

func SerializeItem[T any](key string, object T) ([]byte, error) {
	return json.Marshal(item[T]{key, object})
}

type list[T any] struct {
	Object string    `json:"object"`
	Data   []item[T] `json:"data"`
}

func SerializeList[T any](key string, data []T) ([]byte, error) {
	in := make([]item[T], len(data))
	for i, e := range data {
		in[i] = item[T]{key, e}
	}

	return json.Marshal(list[T]{"list", in})
}
