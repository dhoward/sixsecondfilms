class CreateTweetListeners < ActiveRecord::Migration
  def change
    create_table :tweet_listeners do |t|

      t.timestamps
    end
  end
end
