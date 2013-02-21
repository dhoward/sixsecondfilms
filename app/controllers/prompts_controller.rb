class PromptsController < ApplicationController

	def index
		@prompts = Prompt.find(:all, :order => "id desc", :limit => 25)
		@current_prompt = @prompts.shift(1).first
	end

end
