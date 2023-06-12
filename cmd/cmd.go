package cmd

import (
	"fmt"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
)

func Execute() {
	router := chi.NewRouter()
	router.Use(middleware.Logger)

	router.Get("/", getIndex)

	fmt.Println("listening on http://localhost:4040")
	_ = http.ListenAndServe(":4040", router)
}

func getIndex(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "./static/index.html")
}
