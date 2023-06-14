package exceptions

import (
	"encoding/json"
	"net/http"
)

type errGroup struct {
	Errors     []exception `json:"errors"`
	StatusCode int         `json:"status_code"`
}

type exception struct {
	Code   string `json:"code"`
	Detail string `json:"detail"`
	Status int    `json:"status"`
}

func Unauthenticated(w http.ResponseWriter) {
	err := errGroup{
		Errors:     []exception{{"AuthenicationException", "Unauthenicated.", 401}},
		StatusCode: 401,
	}
	out, _ := json.Marshal(err)

	w.WriteHeader(401)
	w.Write(out)
}

func Forbidden(w http.ResponseWriter) {
	err := errGroup{
		Errors:     []exception{{"AccessDeniedHttpException", "This action is unauthorized.", 403}},
		StatusCode: 403,
	}
	out, _ := json.Marshal(err)

	w.WriteHeader(403)
	w.Write(out)
}

func NotFound(w http.ResponseWriter) {
	err := errGroup{
		Errors:     []exception{{"AuthenicationException", "The requested resource could not be found on the server.", 404}},
		StatusCode: 404,
	}
	out, _ := json.Marshal(err)

	w.WriteHeader(404)
	w.Write(out)
}
