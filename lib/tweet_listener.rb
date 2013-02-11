class TweetListener

	include Singleton	

  @@tweet_stream = TweetStream::Client.new

	def initialize
		puts "TweetListener initialized"

		@@tweet_stream.on_limit do |skip_count|
		  puts "TweetStream RateLimitError: #{skip_count}"
		end

		@@tweet_stream.on_error do |error|
			puts "TweetStream Error: #{error}"
		end
	end

  def track_hashtags(minutes, ending_prompt, *tags)  	
  	@@tweet_stream.stop_stream
  	puts("Tracking hashtags: " + tags.join(", "))

  	EM.run do
		  @@tweet_stream.track(tags) do |status| 
		  	hashtag_used = get_hashtag_used(status.text, tags)
		    puts("Received status: #{status.text}, using hashtag #{hashtag_used}")     
		    if status.retweeted_status
		      Tweet.create_tweet(status.retweeted_status, hashtag_used)
		    else
		      Tweet.create_tweet(status, hashtag_used)
		    end  
		  end

		  EventMachine::Timer.new(minutes * 60) do		  	
		  	EM.stop
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
		@@tweet_stream.stop_stream
	end

end
