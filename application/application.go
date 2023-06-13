package application

import (
	"encoding/json"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/pteropackages/mockdactyl/fractal"
)

func SetRoutes(router chi.Router) {
	router.Use(middleware.AllowContentType("application/json"))

	router.Route("/users", func(r chi.Router) {
		r.Get("/", getUsers)
	})
}

type user struct {
	ID        int    `json:"id"`
	Username  string `json:"username"`
	Email     string `json:"email"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
	RootAdmin bool   `json:"root_admin"`
}

var store []user

func Load(buf []byte) error {
	return json.Unmarshal(buf, &store)
}

func getUsers(w http.ResponseWriter, r *http.Request) {
	out, _ := fractal.SerializeList("user", store)
	w.Write(out)
}
