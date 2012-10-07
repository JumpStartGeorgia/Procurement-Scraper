class Tender < ActiveRecord::Base

  belongs_to :procurring_entity, :class_name => 'Organization', :foreign_key => 'procurring_entity_id'
  has_many :tender_cpv_classifiers, :dependent => :destroy
  has_many :bidders, :dependent => :destroy
  has_one :winning_bid, :class_name => 'Bid', :foreign_key => 'winning_bid_id'

  attr_accessible :url_id, :procurring_entity_id,
      :tender_type,
      :tender_registration_number,
      :tender_status,
      :tender_announcement_date,
      :bid_start_date,
      :bid_end_date,
      :estimated_value, 
      :include_vat,
      :cpv_code,
      :winning_bid_id,
      :start_date,
      :end_date

  validates :url_id, :procurring_entity_id, :tender_type, :tender_registration_number, :tender_status, :presence => true

end
