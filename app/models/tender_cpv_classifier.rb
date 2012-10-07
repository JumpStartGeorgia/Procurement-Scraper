class TenderCpvClassifier < ActiveRecord::Base
  belongs_to :tendor
  
  attr_accessible :tender_id,
      :cpv_code
      
  validates :tender_id, :cpv_code, :presence => true
end
