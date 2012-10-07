class Bidder < ActiveRecord::Base
  belongs_to :tendor
  belongs_to :organization
  has_many :bids, :dependent => :destroy
  
  attr_accessible :tender_id,
      :organization_id
      
  validates :tender_id, :organization_id, :presence => true
end
