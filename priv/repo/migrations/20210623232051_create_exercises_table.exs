defmodule Wabanex.Repo.Migrations.CreateExercisesTable do
  use Ecto.Migration

  def change do
    dreate table(:exercises) do
      add :name, :string
      add :youtube_video_url, :string
      add :protocol_description, :string
      add :repetitions, :string
      add :training_id, references(:trainings)

      timestamps()
    end
  end
end
# To create a new document like this I used a terminal command like: mix ecto.gen.migration create_exercises_table, and after I used: mix ecto.migrate.
