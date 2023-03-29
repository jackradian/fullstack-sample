class AddUpvotesCountDownvotesCountToMovie < ActiveRecord::Migration[7.0]
  def change
    change_table :movies, bulk: true do |t|
      t.integer :upvotes_count, null: false, default: 0
      t.integer :downvotes_count, null: false, default: 0
    end
  end
end
