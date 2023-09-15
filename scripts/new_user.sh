API_KEY=$(curl http://localhost:3000/keygen -sX POST | jq -r .meta.secret_token)
REQ_BODY=<<'EOF'
{
  "username": "sudowoodo",
  "email": "sudo@woodo.com",
  "first_name": "sudo",
  "last_name": "woodo"
}
EOF

curl -X POST http://localhost:3000/api/application/users -H "Authorization: Bearer ptlc_$API_KEY" -d "$REQ_BODY"
