class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.references :prompt_category
      t.references :prompt_item

      t.timestamps
    end
    add_index :tweets, :prompt_category_id
    add_index :tweets, :prompt_item_id
  end
end
