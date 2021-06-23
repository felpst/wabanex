defmodule Wabanex.Users.Get do # This module is responsible for creating a new user.
alias Wabanex.{User, Repo} # Since they are all from the same module, I can use alias for both in one line like this.
alias Ecto.UUID

def call(id) do
    id
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error) do
    {:error, "Invalid UUID"}
  end

  defp handle_response({:ok, uuid}) do
    case Repo.get(User, uuid) do # This case is simillar to a switch case in other languages, and it is used to handle with possibilities.
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
