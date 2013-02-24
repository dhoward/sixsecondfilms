class TweetListener

	include Singleton	

	def initialize
		Rails.logger.info "TweetListener initialized"		
	end

  def track_hashtags(prompt)  	

  	tag = prompt.hashtag
  	
  	Rails.logger.info("Tracking hashtag: " + tag)

		tweet_stream = TweetStream::Client.new
	  	tweet_stream.on_limit do |skip_count|
		  Rails.logger.info "TweetStream RateLimitError: #{skip_count}"
		end

		tweet_stream.on_error do |error|
			Rails.logger.info "TweetStream Error: #{error}"
		end

  	EM.run do
			tweet_stream.track(tag) do |status| 
		    Rails.logger.info("Received status: #{status.text}, using hashtag #{tag}")     
		    if status.retweeted_status
		      Tweet.create_tweet(status.retweeted_status, tag)
		    else
		      Tweet.create_tweet(status, tag)
		    end  
			end

			EventMachine::PeriodicTimer.new(60) do
				if(prompt.is_over?)
					tweet_stream.stop
			  	EM.stop_event_loop
			  end
			end
		end

		prompt.determine_winners
  end

	def stop_listener
		tweet_stream.stop_stream
	end

end
