class Stock < ActiveRecord::Base
  attr_accessible :name, :symbol
  has_many :streams
  validates :symbol, :presence => true
end
