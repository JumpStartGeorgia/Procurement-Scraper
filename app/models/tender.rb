class Tender < ActiveRecord::Base

  belongs_to :procurring_entity, :class_name => 'Organization', :foreign_key => 'procurring_entity_id'
  has_many :tender_cpv_classifiers, :dependent => :destroy
  has_many :bidders, :dependent => :destroy
  has_one :winning_bid, :class_name => 'Bid', :foreign_key => 'winning_bid_id'

  attr_accessible :url_id, 
      :procurring_entity_id,
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

  attr_accessor :sum_estimated_value, :count_tender_status, :procurring_entity_name
  
  ############################################################
  ### special attributes
  ############################################################
  def cpv_name
    return self.cpv_code[self.cpv_code.index("-")+1, self.cpv_code.length]
  end

  ############################################################
  ### aggregate queries
  ############################################################
  # get top estimated values by cpv code
  def self.top_cpv_estimated_values(limit)
    sql = "select cpv_code, sum(estimated_value) as sum_estimated_value "
    sql << "from tenders "
    sql << "group by cpv_code "
    sql << "order by sum_estimated_value desc "
    sql << "limit :limit " if limit
    
    find_by_sql(sql, :limit => limit)
  end

  # get proportion of tender status 
  def self.tender_status_proportional
    values = []
    sql = "select tender_status, count(*) as count_tender_status "
    sql << "from tenders "
    sql << "group by tender_status "
    sql << "order by count_tender_status desc, tender_status asc "
    
    query = find_by_sql(sql)
    
    if query && !query.empty?
      total = query.map{|x| x.count_tender_status}.inject{|sum,x| sum + x }
      
      query.each do |item|
        hash = Hash.new
        hash[:tender_status] = item.tender_status
        hash[:number] = item.count_tender_status
        hash[:percent] = total.to_f / item.count_tender_status * 100
        values << hash
      end
    end
    return values
  end
  

end
