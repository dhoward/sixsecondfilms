class PromptCategory < ActiveRecord::Base
  attr_accessible :text
  has_many :prompt_items
end
