defmodule Amdryzen9600xWeb.HealthController do
  use Amdryzen9600xWeb, :controller

  def show(conn, _params) do
    json(conn, %{status: "ok"})
  end
end
