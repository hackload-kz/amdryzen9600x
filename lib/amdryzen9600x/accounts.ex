defmodule Amdryzen9600x.Accounts do
  import Ecto.Query, warn: false
  alias Amdryzen9600x.Repo
  alias Amdryzen9600x.Accounts.User

  @doc """
  Возвращает активного пользователя при совпадении email+password_plain.
  Email сравнивается case-insensitive.
  """
  def get_active_user_by_email_and_plain_password(email, password)
      when is_binary(email) and is_binary(password) do
    Repo.one(
      from u in User,
      where:
        fragment("LOWER(?)", u.email) == ^String.downcase(email) and
        u.password_plain == ^password and
        u.is_active == true
    )
  end

  @doc "Обновляет last_logged_in."
  def touch_last_login(%User{user_id: id}) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    {_, _} =
      from(u in User, where: u.user_id == ^id)
      |> Repo.update_all(set: [last_logged_in: now])

    :ok
  end
end
