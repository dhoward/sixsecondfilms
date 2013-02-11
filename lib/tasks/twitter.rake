require 'open-uri'

namespace :twitter do

  task :create_contest => :environment do

    last_prompt = Prompt.last
    new_prompt = Prompt.generate_next   
    #Twitter.update(new_prompt.get_tweet_text)        
    
    old_hash = "#{last_prompt.hashtag}"  
    new_hash = "#{new_prompt.hashtag}"
    TweetListener.instance.track_hashtags(1, last_prompt, old_hash, new_hash)

  end
  
end