class Tweet < ActiveRecord::Base
  attr_accessible :retweet_count, :text, :tweet_id, :user_id, :user_name, :vine_url, :hashtag_used

  def self.create_tweet(tweet_info, hashtag)

  	video_url = ""
    tweet_info.attrs[:entities][:urls].each do |url|
      if(url[:expanded_url].include? "vine.co")
        video_url = url[:expanded_url]
      end
    end

    if video_url != ""
    	tweet = Tweet.find_or_initialize_by_tweet_id(tweet_info.id)
    	tweet.update_attributes({
    	  "tweet_id" => tweet_info.id,
    	  "text" => tweet_info.text,
    	  "retweet_count" => tweet_info.retweet_count,
    	  "vine_url" => video_url,
    	  "user_name" => tweet_info.attrs[:user][:screen_name],
    	  "user_id" => tweet_info.attrs[:user][:id],
    	  "hashtag_used" => hashtag
    	})
    else
      Rails.logger.info "NOT A VINE"
    end
  end
end
