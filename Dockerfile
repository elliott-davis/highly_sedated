# Step 1: Build
FROM golang:1.16-alpine AS build

WORKDIR /go/src/app

# add go.sum here if there were dependencies in the mod file
COPY go.mod ./
RUN go mod download

COPY . .
RUN go install -v ./cmd/...


FROM alpine:latest as foo
WORKDIR /app
COPY --from=build /go/bin/foo foo
CMD ["./foo"]

FROM alpine:latest as bar
WORKDIR /app
COPY --from=build /go/bin/bar bar
CMD ["./bar"]

FROM alpine:latest as baz
WORKDIR /app
COPY --from=build /go/bin/baz baz
CMD ["./baz"]