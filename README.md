# IMAPSync use on Windows or Linux using Go

1. Build image and Setup docker container

```bash
$ docker build -t imapsync-goapi .
$ docker run -d -p 8080:8000 --name my-imapsync-goapi imapsync-goapi
```

Test the API

```
curl -X POST http://localhost:8000/sync \
-H "Content-Type: application/json" \
-d '{
  "host1": "source.imap.server",
  "user1": "sourceuser",
  "password1": "sourcepassword",
  "host2": "destination.imap.server",
  "user2": "destinationuser",
  "password2": "destinationpassword"
}'
```