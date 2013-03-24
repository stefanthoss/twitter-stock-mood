class Stream < ActiveRecord::Base
  attr_accessible :name, :stock_id, :consumer_key, :consumer_secret, :oauth_token, :oauth_token_secret
  belongs_to :stock
  has_many :keywords
  has_many :tweets
  validates :name, :presence => true
end
