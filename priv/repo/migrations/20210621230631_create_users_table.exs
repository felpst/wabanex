# This was created using mix ecto.gen.migration "name_of_operation". Ecto is a lib which purpose is to deal with the database
defmodule Wabanex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do # This are the fields that are going to be created for the database
      add :email, :string
      add :name, :string
      add :password, :string

      timestamps() # This function creates a column inserte_at and one also created_at, both are to keep a register of when our entities are created and edited.
    end

    create unique_index(:users, [:email]) # This will make sure that there are no users sharign the same email.
  end
end
# executing mix ecto.migrate in the terminal will execute this migration, and it will create the table in our database.
