class CreatePromptCategories < ActiveRecord::Migration
  def change
    create_table :prompt_categories do |t|
      t.string :text

      t.timestamps
    end
  end
end
