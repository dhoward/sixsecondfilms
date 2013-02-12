class PromptsController < ApplicationController

	def index
		@prompts = Prompt.find(:all, :order => "id desc", :limit => 12)
		@current_prompt = @prompts.shift(1).first
		@voting_prompt = @prompts.shift(1).first

		puts "PROMPTS"
		puts @prompts.length
		puts "CURRENT"
		puts @current_prompt
		puts "Voting"
		puts @voting_prompt
	end

end
