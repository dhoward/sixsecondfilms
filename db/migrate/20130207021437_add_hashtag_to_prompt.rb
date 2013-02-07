class AddHashtagToPrompt < ActiveRecord::Migration
  def change
    add_column :prompts, :hashtag, :string
  end
end
