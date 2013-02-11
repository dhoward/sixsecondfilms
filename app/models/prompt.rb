class Prompt < ActiveRecord::Base
  belongs_to :prompt_category
  belongs_to :prompt_item
  has_many :winners, :foreign_key => 'winner_of', :class_name => "Tweet", :order => 'retweet_count DESC'
  attr_accessible :prompt_category, :prompt_item, :hashtag

  def get_tweet_text
	 "#{prompt_category.text} #{prompt_item.text} \##{prompt_item.hashtag}6sf" 
  end

  def pretty_timestamp
	 created_at.in_time_zone("Pacific Time (US & Canada)").strftime("%l %p %-m/%-d %Z")
  end

  def twitter_hashtag_url
    "https://twitter.com/search?q=#{URI.escape(hashtag)}&src=hash"
  end

  def determine_winners  	
  	tweets = Tweet.where("created_at >= ?", created_at)
  	     .where(:hashtag_used => hashtag)
  	     .find(:all, :order => "retweet_count desc", :limit => 3)

  	tweets.each do |tweet|
  		tweet.winner_of = id
  		tweet.save
  	end  	     
  end

  def self.generate_next

    begin      
      category = PromptCategory.offset(rand(PromptCategory.count)).first
      random_num = rand(category.prompt_items.count)
      item = PromptItem.where("prompt_category_id = ?", category.id)
                       .offset(random_num).first
    end while !Prompt.where('created_at > ?', 1.days.ago).find_by_prompt_category_id_and_prompt_item_id(category.id, item.id).nil?    

    next_hashtag = "##{item.hashtag}6sf"

    next_prompt = Prompt.create(:prompt_category => category, :prompt_item => item, :hashtag => next_hashtag)
    next_prompt
  end

end
