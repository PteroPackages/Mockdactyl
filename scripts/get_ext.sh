#!/usr/bin/env bash
API_KEY=$(curl http://localhost:3000/keygen -sX POST | jq -r .meta.secret_token)
curl http://localhost:3000/api/application/users/external/$1 -H "Authorization: Bearer ptlc_$API_KEY"
