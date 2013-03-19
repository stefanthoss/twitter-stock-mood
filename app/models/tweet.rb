class Tweet < ActiveRecord::Base
  attr_accessible :date, :retweet_count, :stream_id, :text
  belongs_to :stream
end
