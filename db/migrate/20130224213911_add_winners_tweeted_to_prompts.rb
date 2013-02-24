class AddWinnersTweetedToPrompts < ActiveRecord::Migration
  def change
    add_column :prompts, :winners_tweeted, :boolean
  end
end
