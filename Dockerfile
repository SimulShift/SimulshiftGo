# Use the official Golang image to create a build artifact.
# This image is based on Debian and includes Golang installed.
FROM golang:1.21-alpine AS builder

# Set the working directory outside $GOPATH to enable the support for modules.
WORKDIR /app

# Copy the go.mod and go.sum to download all dependencies.
COPY go.mod go.sum ./

# Ensure dependencies are up to date.
RUN go mod tidy && go mod download

# Copy the full application directory into the working directory.
COPY . .

# Build the application to the /app directory.
# -o specifies the output file name, compiled binary will be named server.
RUN CGO_ENABLED=0 GOOS=linux go build -v -o server

# Use the lightweight Alpine image to reduce the final image size.
FROM alpine:latest

# Set the working directory in the container.
WORKDIR /root/

# Copy the pre-built binary file from the previous stage.
# Ensure we use the exact file name as specified in the builder stage.
COPY --from=builder /app/server .

# Expose port 9001 to the outside once the container has launched.
EXPOSE 9001

# Command to run the executable.
CMD ["./server"]
