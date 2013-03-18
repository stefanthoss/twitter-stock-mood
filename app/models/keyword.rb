class Keyword < ActiveRecord::Base
  attr_accessible :name, :stream_id
  belongs_to :stream
  validates :name, :presence => true
end
