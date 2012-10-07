class Organization < ActiveRecord::Base
  has_many :tendors
  has_many :bidders
  
  attr_accessible :url_id,
      :label_id,
      :name,
      :country

  validates :url_id, :label_id, :presence => true
  
  scope :order_by_name, order("name desc")
  scope :recent, order("name desc").limit(5)
  
  # number of items per page for pagination
	self.per_page = 20
end
