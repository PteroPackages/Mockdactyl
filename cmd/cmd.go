package cmd

import (
	"fmt"
	"net/http"
	"os"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/pteropackages/mockdactyl/application"
	"github.com/pteropackages/mockdactyl/auth"
	"github.com/pteropackages/mockdactyl/fractal"
)

func Execute() {
	users, err := os.ReadFile("./store/users.json")
	if err != nil {
		panic(err)
	}

	application.Load(users)

	router := chi.NewRouter()
	router.Use(middleware.Logger)

	router.Get("/", func(w http.ResponseWriter, r *http.Request) {
		http.ServeFile(w, r, "./static/index.html")
	})

	router.Post("/genkey", func(w http.ResponseWriter, r *http.Request) {
		key := auth.CreateAPIKey("auto-generated mockdactyl api key")
		out, _ := fractal.SerializeItem("api_key", key, map[string]any{"secret_token": key.Token})
		w.Write(out)
	})

	router.Route("/api", func(r chi.Router) {
		r.Route("/application", application.SetRoutes)
	})

	fmt.Println("listening on http://localhost:4040")
	_ = http.ListenAndServe(":4040", router)
}
