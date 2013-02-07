class AddWinnerOfToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :winner_of, :integer
  end
end
