class Organization < ActiveRecord::Base
  has_many :tendors
  has_many :bidders
  
  attr_accessible :url_id,
      :label_id,
      :name,
      :country

  validates :url_id, :label_id, :presence => true
  
end
