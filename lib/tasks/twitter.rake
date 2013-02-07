require 'open-uri'

namespace :twitter do

  task :create_contest => :environment do

    new_prompt = Prompt.generate_next   
    #Twitter.update(new_prompt.get_tweet_text)    

    EM.run do
      
      with_hash = "\##{new_prompt.hashtag}"
      puts "Listening for tweets with hashtag #{with_hash}"

      stream = TweetStream::Client.new.track("#{with_hash}") do |status| 
        puts("Received status: " + status.text)     
        if status.retweeted_status
          Tweet.create_tweet(status.retweeted_status, new_prompt.hashtag)
        else
          Tweet.create_tweet(status, new_prompt.hashtag)
        end  
      end

      interval = EventMachine::Timer.new(300) do
        stream.stop
        interval.cancel
        EM.stop
      end
    end
    
    new_prompt.determine_winners

  end
  
end