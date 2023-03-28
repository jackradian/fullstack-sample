class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.integer :vote_type, limit: 1, null: false, default: 0

      t.timestamps
    end

    add_index :votes, [:user_id, :movie_id], unique: true
  end
end
