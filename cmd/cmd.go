package cmd

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/pteropackages/mockdactyl/application"
)

func Execute() {
	router := chi.NewRouter()
	router.Use(middleware.Logger)

	router.Get("/", getIndex)

	router.Route("/api", func(r chi.Router) {
		r.Route("/application", application.SetRoutes)
	})

	fmt.Println("listening on http://localhost:4040")
	_ = http.ListenAndServe(":4040", router)
}

func getIndex(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "./static/index.html")
}
