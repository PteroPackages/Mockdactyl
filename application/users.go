package application

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/pteropackages/mockdactyl/auth"
	"github.com/pteropackages/mockdactyl/exceptions"
	"github.com/pteropackages/mockdactyl/fractal"
)

func SetRoutes(router chi.Router) {
	router.Use(auth.VerifyAPIKey)
	router.Use(middleware.AllowContentType("application/json"))

	router.Route("/users", func(r chi.Router) {
		r.Get("/", getUsers)
		r.Get("/{id}", getUser)
		r.Get("/external/{id}", getExternalUser)
		r.Post("/", postUser)
	})
}

type user struct {
	ID         int    `json:"id"`
	ExternalID string `json:"external_id,omitempty"`
	UUID       string `json:"uuid"`
	Username   string `json:"username"`
	Email      string `json:"email"`
	FirstName  string `json:"first_name"`
	LastName   string `json:"last_name"`
	Language   string `json:"language"`
	RootAdmin  bool   `json:"root_admin"`
	TwoFactor  bool   `json:"2fa"`
	CreatedAt  string `json:"created_at"`
	UpdatedAt  string `json:"updated_at,omitempty"`
}

var store []user

func Load(buf []byte) error {
	return json.Unmarshal(buf, &store)
}

func getUsers(w http.ResponseWriter, r *http.Request) {
	out, _ := fractal.SerializeList("user", store)
	w.Write(out)
}

func getUser(w http.ResponseWriter, r *http.Request) {
	id, _ := strconv.Atoi(chi.URLParam(r, "id"))

	for _, u := range store {
		if u.ID == id {
			out, _ := fractal.SerializeItem("user", u, nil)
			w.Write(out)
			return
		}
	}

	exceptions.NotFound(w)
}

func getExternalUser(w http.ResponseWriter, r *http.Request) {
	id := chi.URLParam(r, "id")

	for _, u := range store {
		if u.ExternalID == id {
			out, _ := fractal.SerializeItem("user", u, nil)
			w.Write(out)
			return
		}
	}

	exceptions.NotFound(w)
}

func postUser(w http.ResponseWriter, r *http.Request) {
	var data struct {
		Username  string `json:"username"`
		Email     string `json:"email"`
		FirstName string `json:"first_name"`
		LastName  string `json:"last_name"`
		Language  string `json:"language,omitempty"`
		RootAdmin bool   `json:"root_admin"`
	}

	defer r.Body.Close()
	buf, err := io.ReadAll(r.Body)
	if err != nil {
		exceptions.BadRequest(w, err.Error())
		return
	}

	if err := json.Unmarshal(buf, &data); err != nil {
		msg := fmt.Sprintf("The JSON data passed in the request appears to be malformed: %s", err)
		exceptions.BadRequest(w, msg)
		return
	}
}
