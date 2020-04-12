![alt flow](flow.png)

## About this project

Flow App was created to create and manager candidates at Jaya.

## How this project work

[![Flow - Candidate](http://img.youtube.com/vi/YVP5h4t0YR8/0.jpg)](http://www.youtube.com/watch?v=YVP5h4t0YR8 "Flow")

## Tech

* Phoenix 
* Elixir
* Erlang
* Postgres

## Dependencies

* Test 

```bash
docker run --name=flow_test -d -p 9000:5432  -e POSTGRES_PASSWORD=sa -e POSTGRES_USER=sa -e POSTGRES_DB=flow_test postgres
```

* Dev 

```bash
docker run --name=flow_dev -d -p 5432:5432  -e POSTGRES_PASSWORD=sa -e POSTGRES_USER=sa -e POSTGRES_DB=flow_dev postgres
```

## Create schema

```bash
mix ecto.create
mix ecto.migrate
```

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
