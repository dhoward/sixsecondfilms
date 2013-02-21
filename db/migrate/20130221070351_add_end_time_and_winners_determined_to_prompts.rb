class AddEndTimeAndWinnersDeterminedToPrompts < ActiveRecord::Migration
  def change
    add_column :prompts, :end_time, :datetime
    add_column :prompts, :winners_determined, :boolean
  end
end
