class Bid < ActiveRecord::Base
  belongs_to :bidder
  
  attr_accessible :bidder_id,
      :bid_date,
      :value
      
  validates :bidder_id, :bid_date, :value, :presence => true
end
