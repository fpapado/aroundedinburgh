# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Around.Repo.insert!(%AroundWeb.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Around.Repo
alias AroundWeb.Category

for category <- ~w(Eat Drink Chill Study Visit) do
    Repo.get_by(Category, name: category) ||
        Repo.insert!(%Category{name: category})
end
