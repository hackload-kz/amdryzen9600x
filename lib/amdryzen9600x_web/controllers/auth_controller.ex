defmodule Amdryzen9600xWeb.AuthController do
  use Amdryzen9600xWeb, :controller

  plug Amdryzen9600xWeb.Plugs.BasicAuth

  def check(conn, _params) do
    json(conn, %{
      status: "ok",
      user: conn.assigns[:current_user].email
    })
  end
end
