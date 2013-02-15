module ApplicationHelper

	def get_prompt_margin(winners)

		if winners == 3
			"52px"
		elsif winners == 2
			"153px"
		else
			"355px"
		end

	end

end