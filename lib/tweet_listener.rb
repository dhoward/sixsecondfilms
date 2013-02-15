class TweetListener

	include Singleton	

	def initialize
		Rails.logger.info "TweetListener initialized"		
	end

  def track_hashtags(minutes, ending_prompt, *tags)  	
  	
  	Rails.logger.info("Tracking hashtags: " + tags.join(", "))

	tweet_stream = TweetStream::Client.new
  	tweet_stream.on_limit do |skip_count|
	  Rails.logger.info "TweetStream RateLimitError: #{skip_count}"
	end

	tweet_stream.on_error do |error|
		Rails.logger.info "TweetStream Error: #{error}"
	end

  	EM.run do
		tweet_stream.track(tags) do |status| 
		  	hashtag_used = get_hashtag_used(status.text, tags)
		    Rails.logger.info("Received status: #{status.text}, using hashtag #{hashtag_used}")     
		    if status.retweeted_status
		      Tweet.create_tweet(status.retweeted_status, hashtag_used)
		    else
		      Tweet.create_tweet(status, hashtag_used)
		    end  
		end

		EventMachine::Timer.new(minutes * 60) do
			tweet_stream.stop
		  	EM.stop_event_loop
		end
	end

	ending_prompt.determine_winners
  end

	def get_hashtag_used(tweet, tags)
		for tag in tags
			if tweet =~ /#{tag}/i
				return tag
			end
		end
	end

	def stop_listener
		tweet_stream.stop_stream
	end

end
