FROM golang:1.19.2-alpine AS build

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

ENV USER=appuser
ENV UID=10001

# See https://stackoverflow.com/a/55757473/12429735
RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/nonexistent" \
  --shell "/sbin/nologin" \
  --no-create-home \
  --uid "${UID}" \
  "${USER}"

WORKDIR $GOPATH/src/github.com/luisfelipecunhaduarte/lab-conversa-docker

COPY . .

RUN go get -d -v
RUN go mod download
RUN go mod verify

#RUN go build -o /application
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/lab-conversa-docker

FROM alpine:3.16.0

# Import the user and group files from the builder.
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/group /etc/group

COPY --from=build /go/bin/lab-conversa-docker /go/bin/lab-conversa-docker

# Use an unprivileged user.
USER appuser:appuser

ENTRYPOINT [ "/go/bin/lab-conversa-docker" ]