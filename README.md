# IMAPSync use on Windows or Linux using Python 3

> Prepare Virtual Environment before commencing

1. Install python 3.9 dependencies:

```bash
$ pip install -r requirements.txt
```

2. Run the API

```bash
$ uvicorn app:app --host 127.0.0.1 --port 8000
```

3. Test the API

```
curl -X POST http://127.0.0.1:8000/sync \
-H "Content-Type: application/json" \
-d '{
    "source": {
        "host": "source.imap.server",
        "user": "sourceuser",
        "password": "sourcepassword"
    },
    "destination": {
        "host": "destination.imap.server",
        "user": "destinationuser",
        "password": "destinationpassword"
    }
}'
```