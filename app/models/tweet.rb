class Tweet < ActiveRecord::Base
  attr_accessible :date, :mood_negative, :mood_positive, :stream_id
  belongs_to :stream
end
