package main

import (
    "encoding/json"
    "fmt"
    "net/http"
    "os/exec"
)

type SyncRequest struct {
    Host1     string `json:"host1"`
    User1     string `json:"user1"`
    Password1 string `json:"password1"`
    Host2     string `json:"host2"`
    User2     string `json:"user2"`
    Password2 string `json:"password2"`
}

func syncEmails(w http.ResponseWriter, r *http.Request) {
    if r.Method != http.MethodPost {
        http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
        return
    }

    var syncReq SyncRequest
    if err := json.NewDecoder(r.Body).Decode(&syncReq); err != nil {
        http.Error(w, "Invalid request payload", http.StatusBadRequest)
        return
    }

    // Construct the imapsync command
    cmd := exec.Command("imapsync",
        "--host1", syncReq.Host1,
        "--user1", syncReq.User1,
        "--password1", syncReq.Password1,
        "--host2", syncReq.Host2,
        "--user2", syncReq.User2,
        "--password2", syncReq.Password2)

    output, err := cmd.CombinedOutput()
    if err != nil {
        http.Error(w, fmt.Sprintf("Error syncing emails: %s", err), http.StatusInternalServerError)
        return
    }
    w.WriteHeader(http.StatusOK)
    w.Write(output)
}

func main() {
    http.HandleFunc("/sync", syncEmails)
    fmt.Println("Starting server on :8000")
    
    if err := http.ListenAndServe(":8000", nil); err != nil {
        fmt.Printf("Error starting server: %s\n", err)
    }
}