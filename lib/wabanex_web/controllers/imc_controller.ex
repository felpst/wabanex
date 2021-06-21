defmodule WabanexWeb.IMCController do # WabanexWeb since we are inside the Wabanex folder
  use WabanexWeb, :controller # since this is a controller I am using the use WabanexWeb, :controller. A controller must always return a response (using the conn)

  alias Wabanex.IMC # Here, since this module has more than one name, I am creating a nickename for it, that by standard is its last name (IMC)

  def index(conn, params) do # Here I am defining the action that I have created inside my router as a function. All actions of a controller on phoenix recevies two parameters by default. Phoenix is a web framwework that handles request responses and logics.
    params
    |> IMC.calculate()
    |> handle_response(conn)
    conn
  end

  defp handle_response({:ok, result}, conn), do: render_response(conn, result, :ok)

  defp handle_response({:error, result}, conn), do: render_response(conn, result, :bad_request)

  defp render_response(conn, result, status) do
    conn
    |> put_status(status) # Here I am setting the status of the response to 200
    |> json(%{result: result}) # Here I am rendering the result as a JSON file. Here since I am using an atom to create the map and not a string ("key"=> content), I am able to access it using map.key, instead of map["key"]. Elixer also has a fixed number of atoms, so the program will auto use string instead of atoms to protect against any attack.
  end
end
