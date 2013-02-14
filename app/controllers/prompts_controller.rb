class PromptsController < ApplicationController

	def index
		@prompts = Prompt.find(:all, :order => "id desc", :limit => 12)
		@current_prompt = @prompts.shift(1).first
		@voting_prompt = @prompts.shift(1).first
	end

end
