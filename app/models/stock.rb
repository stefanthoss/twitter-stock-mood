class Stock < ActiveRecord::Base
  attr_accessible :name, :symbol, :time_zone
  has_many :streams
  validates :symbol, :presence => true
end
