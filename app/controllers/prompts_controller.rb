class PromptsController < ApplicationController

	def index
		@prompts = Prompt.find(:all, :order => "id desc", :limit => 3)
	end

end
