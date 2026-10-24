# Life Hub

## Docker

Run these commands from the repository root with Docker running.

Start the API and PostgreSQL:

```powershell
docker compose -f infra/docker-compose.yml up -d --build
```

- API: http://localhost:5209
- PostgreSQL: `localhost:5434`
- Database, username, and password for local development: `lifehub`

View logs:

```powershell
docker compose -f infra/docker-compose.yml logs -f
```

Stop the containers:

```powershell
docker compose -f infra/docker-compose.yml down
```

Database data is stored in the `postgres_data` Docker volume and retained when stopping the containers.
