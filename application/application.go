package application

import (
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
	ID        int
	Username  string
	Email     string
	FirstName string
	LastName  string
	RootAdmin bool
}

func getUsers(w http.ResponseWriter, r *http.Request) {
	out, _ := fractal.SerializeList("user", []user{
		{ID: 1, Username: "sudo", Email: "example@example.com", FirstName: "sudo", LastName: "sudo", RootAdmin: false},
	})

	w.Write(out)
}
