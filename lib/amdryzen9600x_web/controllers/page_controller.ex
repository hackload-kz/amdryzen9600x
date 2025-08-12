defmodule Amdryzen9600xWeb.PageController do
  use Amdryzen9600xWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
