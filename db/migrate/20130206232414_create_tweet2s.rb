class CreateTweet2s < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :tweet_id, :limit => 8
      t.string :text
      t.string :user_name
      t.integer :user_id, :limit => 8
      t.integer :retweet_count
      t.string :vine_url

      t.timestamps
    end
  end
end
