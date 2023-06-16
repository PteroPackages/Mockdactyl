package auth

import (
	"math/rand"
	"net/http"
	"time"

	"github.com/pteropackages/mockdactyl/exceptions"
)

func init() {
	rand.Seed(time.Now().UnixNano())
}

var (
	chars    = []byte("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
	keyStore []APIKey
)

type APIKey struct {
	Identifier  string   `json:"identifier"`
	Token       string   `json:"-"`
	Description string   `json:"description"`
	AllowedIPs  []string `json:"allowed_ips"`
	CreatedAt   string   `json:"created_at"`
	LastUsedAt  *string  `json:"last_used_at"`
}

func CreateAPIKey(desc string) APIKey {
	token := generateToken(32)
	key := APIKey{
		Identifier:  token[5:13],
		Token:       token,
		Description: desc,
		AllowedIPs:  []string{},
		CreatedAt:   time.Now().Format(time.RFC3339Nano),
	}
	keyStore = append(keyStore, key)

	return key
}

func VerifyAPIKey(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		token := r.Header.Get("Authorization")
		if token == "" || token[0:12] != "Bearer ptlc_" {
			exceptions.Unauthenticated(w)
			return
		}
		token = token[7:]

		for _, k := range keyStore {
			if k.Token == token {
				next.ServeHTTP(w, r)
				return
			}
		}

		exceptions.Unauthenticated(w)
	})
}

func generateToken(length int) string {
	buf := make([]byte, length)
	for i := range buf {
		buf[i] = chars[rand.Intn(62)]
	}
	return "ptlc_" + string(buf)
}
