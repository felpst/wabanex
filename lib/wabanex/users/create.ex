defmodule Wabanex.Users.Create do # This module is responsible for creating a new user.
alias Wabanex.{User, Repo} # Since they are all from the same module, I can use alias for both in one line like this.

def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
