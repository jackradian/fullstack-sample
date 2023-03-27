# Project Fullstack

## Technologies

### API

- Ruby 3.2.1
- Rails 7.0.4

### Frontend

- Nodejs 18.15.0
- React 18.2

## Prerequisites

- Docker ^20.10.23

## Installation

1. Build container

```sh
docker compose build
```

2. Install ruby gems

```sh
docker compose run --rm api-bash-shell bundle install
```

3. Initial database

```sh
docker compose run --rm api-bash-shell bin/rails db:setup
docker compose run --rm -e RAILS_ENV=test api-bash-shell bin/rails db:create
```

4. Install node packages

```sh
docker compose run --rm frontend-bash-shell npm install
```

## Run app

### API

Start API server

```sh
docker compose up api
```

It will be hosted on http://localhost:3000

### Frontend

Start Frontend dev server

```sh
docker compose up frontend
```

It will be hosted on http://localhost:5173

## Stop app

Use `Ctrl` + `C` or use command `docker compose down`

## Run test
