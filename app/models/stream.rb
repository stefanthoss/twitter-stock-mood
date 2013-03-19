class Stream < ActiveRecord::Base
  attr_accessible :name, :stock_id
  belongs_to :stock
  has_many :keywords, :tweets
  validates :name, :presence => true
end
