class RenameTweetsToPrompts < ActiveRecord::Migration
  def up
  	rename_table("tweets", "prompts")
  end

  def down
  	rename_table("prompts", "tweets")
  end
end
