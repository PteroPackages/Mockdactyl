package fractal

import "encoding/json"

type item[T any] struct {
	Object     string         `json:"object"`
	Attributes T              `json:"attributes"`
	Meta       map[string]any `json:"meta,omitempty"`
}

// TODO: deserialize functions

func SerializeItem[T any](key string, object T, meta map[string]any) ([]byte, error) {
	return json.Marshal(item[T]{key, object, meta})
}

type list[T any] struct {
	Object string    `json:"object"`
	Data   []item[T] `json:"data"`
}

func SerializeList[T any](key string, data []T) ([]byte, error) {
	in := make([]item[T], len(data))
	for i, e := range data {
		in[i] = item[T]{key, e, nil}
	}

	return json.Marshal(list[T]{"list", in})
}
