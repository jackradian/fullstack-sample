class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.references :user, null: false, foreign_key: true
      t.string :url

      t.timestamps
    end
    add_index :movies, :created_at
  end
end
