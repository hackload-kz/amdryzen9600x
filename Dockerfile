FROM elixir:latest

# Install debian packages
RUN apt-get update && \
    apt-get install --yes build-essential inotify-tools postgresql-client git && \
    apt-get clean

# Install Phoenix packages
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install --force hex phx_new 1.8.0

# Copy app files
ADD . /app
WORKDIR /app

# Make entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Install Elixir dependencies
RUN mix deps.get

EXPOSE 4000
CMD ["/app/entrypoint.sh"]
