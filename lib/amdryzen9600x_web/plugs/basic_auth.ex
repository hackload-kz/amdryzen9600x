defmodule Amdryzen9600xWeb.Plugs.BasicAuth do
  @behaviour Plug

  import Plug.Conn
  alias Amdryzen9600x.Accounts

  @impl Plug
  def init(opts), do: opts

  @impl Plug
  def call(conn, _opts) do
    with ["Basic " <> b64] <- get_req_header(conn, "authorization"),
         {:ok, decoded}     <- decode64(b64),
         {:ok, email, pass} <- split_email_pass(decoded),
         %{} = user         <- Accounts.get_active_user_by_email_and_plain_password(email, pass) do
      _ = Accounts.touch_last_login(user)
      assign(conn, :current_user, user)
    else
      _ ->
        conn
        |> put_resp_header("www-authenticate", ~s(Basic realm="Amdryzen9600x API"))
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: "Unauthorized"}))
        |> halt()
    end
  end

  # --- helpers ---

  defp decode64(b64) do
    case Base.decode64(b64) do
      {:ok, decoded} -> {:ok, decoded}
      :error -> {:error, :bad_base64}
    end
  end

  defp split_email_pass(decoded) do
    case String.split(decoded, ":", parts: 2) do
      [email, pass] -> {:ok, email, pass}
      _ -> {:error, :bad_format}
    end
  end
end