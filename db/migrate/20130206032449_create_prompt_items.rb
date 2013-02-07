class CreatePromptItems < ActiveRecord::Migration
  def change
    create_table :prompt_items do |t|
      t.string :text
      t.string :hashtag
      t.references :prompt_category

      t.timestamps
    end
    add_index :prompt_items, :prompt_category_id
  end
end
