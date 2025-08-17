#!/bin/bash
# Docker entrypoint script.

# Wait until Postgres is ready
echo "Testing if Postgres is accepting connections. PGHOST=$PGHOST PGPORT=$PGPORT"

# Use pg_isready without the -U flag (it doesn't need username)
while ! pg_isready -q -h $PGHOST -p $PGPORT
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

echo "Database is ready!"

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -h $PGHOST -p $PGPORT -U $PGUSER -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
fi

echo "Starting Phoenix server..."
exec mix phx.server