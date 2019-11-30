# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BaseBlog.Repo.insert!(%BaseBlog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BaseBlog.Repo
alias BaseBlog.Posts.Tag
alias BaseBlog.Accounts.User
alias BaseBlog.Accounts

Repo.insert!(
    %Tag{
        name: "Categoria 1"
    }
)
Accounts.create_user(%{
    email: "admin@admin.com", 
    name: "admin",
    birthday: ~D[1990-10-05],
    password: "admin1",
    password_confirmation: "admin1",
    author: %{
        nickname: "admin"
    }
})