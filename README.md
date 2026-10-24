# Life Hub

Life Hub is being prepared for a new Flutter frontend written in Dart, backed by
the existing C# ASP.NET Core API and PostgreSQL database.

The previous React frontend has been removed. The Flutter application has not
been created yet; the first screen to rebuild is the Weight page. The old page
supported listing, adding, editing, and deleting weight and sleep-hour entries.
Its implementation remains available in Git history.

## Project structure

- `backend/`: .NET 10 API, Entity Framework Core models, and database migrations.
- `infra/`: Docker Compose setup for the API and PostgreSQL.

## Run the backend

From the repository root:

```powershell
docker compose -f infra/docker-compose.yml up -d --build
```

- API: `http://localhost:5209`
- Weight entries: `http://localhost:5209/api/WeightEntries`
- Sleep-hour entries: `http://localhost:5209/api/HourEntries`
- PostgreSQL: `localhost:5434`, database `lifehub`

See [infra/README.md](infra/README.md) for database and container details.

## Frontend rebuild

The API currently allows browser requests from `http://localhost:5173`.
When setting up Flutter web, use that development origin or update the API's
CORS policy to match the chosen origin.
