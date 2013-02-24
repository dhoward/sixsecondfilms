class Prompt < ActiveRecord::Base
  belongs_to :prompt_category
  belongs_to :prompt_item
  has_many :winners, :foreign_key => 'winner_of', :class_name => "Tweet", :order => 'retweet_count DESC'
  attr_accessible :prompt_category, :prompt_item, :hashtag, :end_time, :winners_determined

  def get_tweet_text
	 "#{prompt_category.text} #{prompt_item.text}" 
  end

  def pretty_timestamp
	 created_at.strftime("%-m/%-d")
  end

  def twitter_hashtag_url
    "https://twitter.com/search?q=#{URI.escape(hashtag)}&src=hash"
  end

  def stringify_winners(names)
    names_string = ""
    case names.length
    when 1 
      names_string = "#{names[0]}, winner"
    when 2
      names_string = "#{names[0]} and #{names[1]}, winners"
    when 3
      names_string = "#{names[0]}, #{names[1]}, and #{names[2]}, winners"
    end
    names_string
  end

  def tweet_winners
    if(self.winners.length > 0)
      names = self.winners.map {
        |w| "@#{w.user_name}"
      }

      names_string = stringify_winners(names.uniq)

      tweet_text = "Congrats to #{names_string} of yesterday's 6SF. Check out their work at 6secfilms.com"
      if Rails.env.production?
        Twitter.update(tweet_text)
      else
        puts("Would have tweeted: #{tweet_text}")
      end

      self.winners_tweeted = true
      self.save
    end
  end

  def determine_winners  	

    Rails.logger.info "Determining winners for prompt: #{get_tweet_text}"

  	tweets = Tweet.where("created_at >= ?", created_at)
  	     .where(:hashtag_used => hashtag)
  	     .find(:all, :order => "retweet_count desc", :limit => 3)

    Rails.logger.info "Winners: #{winners.length}"

  	tweets.each do |tweet|
  		tweet.winner_of = id
  		tweet.save
  	end  	    

    self.winners_determined = true
    self.save

  end

  def is_over?
      end_time.in_time_zone("Pacific Time (US & Canada)") < Time.now.in_time_zone("Pacific Time (US & Canada)")
  end

  def self.generate_next

    Rails.logger.info "Beginning new contest"

    begin      
      category = PromptCategory.offset(rand(PromptCategory.count)).first
      random_num = rand(category.prompt_items.count)
      item = PromptItem.where("prompt_category_id = ?", category.id)
                       .offset(random_num).first
    end while !Prompt.where('created_at > ?', 1.days.ago).find_by_prompt_category_id_and_prompt_item_id(category.id, item.id).nil?    

    next_hashtag = "##{item.hashtag}6sf"

    #tomorrow at 6:55 am PST
    if Rails.env.production?
      end_time = Time.now.in_time_zone("Pacific Time (US & Canada)")
                    .change({:hour => 7 , :min => 0 , :sec => 0 }) + Rails.configuration.contest_time                    
    else
      end_time = Time.now.in_time_zone("Pacific Time (US & Canada)") + Rails.configuration.contest_time 
    end

    next_prompt = Prompt.create(:prompt_category => category, 
                                :prompt_item => item, 
                                :hashtag => next_hashtag,
                                :end_time => end_time,
                                :winners_determined => false,
                                :winners_tweeted => false)

    twitter_text = "#{next_prompt.get_tweet_text} #{next_prompt.hashtag} www.6secfilms.com"
    if Rails.env.production?
      Twitter.update(twitter_text)  
    end
    
    Rails.logger.info "Generated new prompt: #{next_prompt.get_tweet_text}"

    next_prompt
  end

end
