defmodule Wabanex.Training do # Schema is the data manipulation part, this is simillar to models in the MVC approach for OOP languages
  use Ecto.Schema # This is used so I can use all the functionalities of a schema. The "use" keyword injects all the code of a module into another module.
  import Ecto.Changeset # While the "import" keyword only gets the modules funtions. The changeset will define how my data will be changed (converted and validated)

  alias Wabanex.{User, Exercise}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:end_date, :start_date, :user_id] # Here I am creating a module variable, that is basically a const variable that only exists inside of this module.

  schema "trainings" do # Here I am defining that I am going to have a user, any value that I receive as email I will try to cast for string and so on.
    field :end_date, :date
    field :start_date, :date

    belongs_to :user, User # A exercise belongs to one user
    has_many :exercises, Exercise # But has many exercises.

    timestamps()
  end

  def changeset(params) do # This function is receiving the data from the user that is going to be validated as params.
    %__MODULE__{} # Normally all the changeset functions for data insertion on the database starts with a empty struct. %__MODULE__ is the same thing as typing Wabanex.User
    |> cast(params, @fields) # cast is a function inside of the changeset from Ecto. Casting means basically converting one data type into another. cast() needs a empty structure, which parameters that I want to cast (in this case those are coming from the changeset function params), and which are the fields that I want to cast. Here I am taking the data that I am receiving from my changeset and mapping them to the @fields.
    |> validate_required(@fields) # This validates the fields that are required, and check if all of them were received.
    |> unique_constraint([:email]) # This will make sure that there are no emails like this inside the database.
    |> cast_assoc(:exercises) # This will make a validation and casting of all the exercises.
  end
end
# A struct is a basically a map with a name.
