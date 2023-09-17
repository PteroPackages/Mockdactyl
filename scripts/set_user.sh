#!/usr/bin/env bash
API_KEY=$(curl http://localhost:3000/keygen -sX POST | jq -r .meta.secret_token)
read -r -d '' REQ_BODY <<-'EOF'
{
  "username": "woodosudo",
  "email": "woodo@sudo.com",
  "first_name": "woodo",
  "last_name": "sudo"
}
EOF

curl -X PATCH http://localhost:3000/api/application/users/11 \
  -H "Authorization: Bearer ptlc_$API_KEY" \
  -H "Content-Type: application/json" \
  -d "$REQ_BODY"
