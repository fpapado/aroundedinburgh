defmodule AroundWeb.UserView do
    use AroundWeb, :view
    alias Around.Accounts.User

    def first_name(%User{name: name}) do
        name
        |> String.split(" ")
        |> Enum.at(0)
    end
end
