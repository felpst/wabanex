defmodule Wabanex.User do # Schema is the data manipulation part, this is simillar to models in the MVC approach for OOP languages
  use Ecto.Schema # This is used so I can use all the functionalities of a schema. The "use" keyword injects all the code of a module into another module.
  import Ecto.Changeset # While the "import" keyword only gets the modules funtions. The changeset will define how my data will be changed (converted and validated)

  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :password, :name] # Here I am creating a module variable, that is basically a const variable that only exists inside of this module.

  schema "users" do # Here I am defining that I am going to have a user, any value that I receive as email I will try to cast for string and so on.
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  def changeset(params) do # This function is receiving the data from the user that is going to be validated as params.
    %__MODULE__{} # Normally all the changeset functions for data insertion on the database starts with a empty struct. %__MODULE__ is the same thing as typing Wabanex.User
    |> cast(params, @fields) # cast is a function inside of the changeset from Ecto. Casting means basically converting one data type into another. cast() needs a empty structure, which parameters that I want to cast (in this case those are coming from the changeset function params), and which are the fields that I want to cast. Here I am taking the data that I am receiving from my changeset and mapping them to the @fields.
    |> validate_required(@fields) # This validates the fields that are required, and check if all of them were received.
    |> validate_length(:password, min: 6) # This makes sure that the password is at least 6 characters long.
    |> validate_length(:name, min: 2) # This makes sure that the name is at least 2 characters long.
    |> validate_format(:email, ~r/@/) # This is validating if there is a @ in the email.
    |> unique_constraint([:email]) # This will make sure that there are no emails like this inside the database.
  end
end
# A struct is a basically a map with a name.
