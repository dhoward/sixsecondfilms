class AddHashtagUsedToTweet < ActiveRecord::Migration
  def change
  	add_column :tweets, :hashtag_used, :string
  end
end
