# Use a lightweight Golang base image
FROM golang:alpine

# Set working directory
WORKDIR /app

# Copy source code into container
COPY . .

# Expose port 8000
EXPOSE 8000

# Command to run the application
CMD ["go", "run", "main.go"]