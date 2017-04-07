class CreateMovieRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_relationships do |t|
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
