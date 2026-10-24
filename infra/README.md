# Lokal backend med Docker

Kör från repots rot. Stoppa först ett eventuellt lokalt `dotnet run` med Ctrl+C,
eftersom både det och Docker använder port 5209.

```powershell
docker compose -f infra/docker-compose.yml up -d --build
```

API: http://localhost:5209/api/WeightEntries

Den tidigare React-frontenden har tagits bort. En ny Flutter-frontend ska byggas och ansluta till API:et på http://localhost:5209.

CORS-policyn i `backend/LifeHub.Api/Program.cs` tillåter frontend på
http://localhost:5173. Använd samma origin för Flutter-utvecklingen eller uppdatera CORS-policyn när den nya frontenden konfigureras.

API-containern ansluter till `postgres:5432`. Från datorn når du databasen på
`localhost:5434`. Befintliga data ligger kvar i volymen `postgres_data`.
Databasens befintliga schema används; starten kör inga EF-migreringar automatiskt.

Efter backendändringar kör du startkommandot igen för att bygga om avbilden.

Visa loggar:

```powershell
docker compose -f infra/docker-compose.yml logs -f api
```

Stoppa containrarna och behåll datavolymen:

```powershell
docker compose -f infra/docker-compose.yml down
```
