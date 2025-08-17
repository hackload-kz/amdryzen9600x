alias Amdryzen9600x.{Repo}
alias Amdryzen9600x.Accounts.User

now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

Repo.insert!(
  %User{
    user_id: 1,
    email: "user@gmail.com",
    password_hash: "deprecated",
    password_plain: "plainpass",
    first_name: "Demo",
    surname: "User",
    birthday: ~D[1995-05-01],
    registered_at: now,
    is_active: true,
    last_logged_in: now
  },
  on_conflict: :nothing
)
