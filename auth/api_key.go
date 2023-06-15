package auth

import (
	"math/rand"
	"time"
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

func generateToken(length int) string {
	buf := make([]byte, length)
	for i := range buf {
		buf[i] = chars[rand.Intn(62)]
	}
	return "ptlc_" + string(buf)
}
