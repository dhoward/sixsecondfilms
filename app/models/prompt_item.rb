class PromptItem < ActiveRecord::Base
  belongs_to :prompt_category
  attr_accessible :hashtag, :text, :prompt_category, :prompt_category_id
end
