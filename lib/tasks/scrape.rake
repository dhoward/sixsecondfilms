require 'open-uri'

namespace :scrape do
  
  task :twitter => :environment do
    base_url = "http://search.twitter.com/search.json?include_entities=true&lang=en&result_type=recent&rpp=100&q=batman%20vine.co&page="
    after_name = "1"
    another_page = false
    
    (1...150).each do |i|
      another_page = false
      buffer = open(base_url+after_name).read
      json = JSON.parse(buffer)
    
      json["results"].each do |result|
        another_page = true
        tweet_id = result["id"]
                        
        tweet_url = "http://api.twitter.com/1/statuses/show/#{tweet_id}.json?include_entities=true"
        puts("OPENING: " + tweet_url)
        buffer = open(tweet_url).read
        tweet = JSON.parse(buffer)        

        text = tweet["text"]
        user_name = tweet["user"]["screen_name"]
        retweets = tweet["retweet_count"]
        video_url = ""
        tweet["entities"]["urls"].each do |url|
          if(url["expanded_url"].include? "vine.co")
            video_url = url["expanded_url"]
          end
        end

        puts(tweet_id)
        puts(text)
        puts(user_name)
        puts(retweets)
        puts(video_url)
        puts("-------------")
        
        if(another_page == false)
          break
        end
        
      end
    end
  end
  
end