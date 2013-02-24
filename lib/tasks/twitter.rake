require 'open-uri'

namespace :twitter do

  task :run_contest => :environment do

		prompt = Prompt.last || Prompt.generate_next

		if(prompt.is_over?)
			if(prompt.winners_determined != true)
				prompt.determine_winners
			end

			if(prompt.winners_tweeted != true)
				prompt.tweet_winners
			end

			prompt = Prompt.generate_next

		else
			Rails.logger.debug "Continuing old contest"
		end
		
		TweetListener.instance.track_hashtags(prompt)

  end
  
end