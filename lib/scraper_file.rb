module ScraperFile

  def self.process
    start = Time.now
    
    I18n.locale = :en # do this so formating of floats and dates is correct when reading in json
    # get the json file
    file_path = "#{Rails.root}/public/system/items.json"    
    file_data = File.open(file_path, "r") {|f| f.read()}
    
    if file_data
      Rails.logger.debug " - found json file"
      # take out extra ',' at end of data
      json = JSON.parse(file_data.gsub("},]", "}]"))
      
      Tender.transaction do
        Tender.delete_all
        
        json.each_with_index do |item, index|
          tender = Tender.new

          # basic tender info
          tender.url_id = item["urlID"]
          tender.tender_type = item["tenderType"]
          tender.tender_registration_number = item["tenderRegistrationNumber"]
          tender.tender_status = item["tenderStatus"]
          tender.tender_announcement_date = item["tenderAnnouncementDate"]
          tender.bid_start_date = item["bidsStartDate"]
          tender.bid_end_date = item["bidsEndDate"]
          tender.estimated_value = item["estimatedValue"].gsub("`","").to_f
          tender.cpv_code = item["cpvCode"]
        
          # if the organization does not exist yet, add it
          tender.procurring_entity_id = item["procuringEntityID"]
          tender.procurring_entity_name = item["procuringEntityName"]

          if tender.valid?
            tender.save
          else
            Rails.logger.debug "***** tender was not valid: #{tender.errors} *****"
		        raise ActiveRecord::Rollback
		        return "ERROR: An error occurred while saving json record #{index}"
          end
        end
      end
      
    end
    
    Rails.logger.debug "###### total time = #{Time.now - start} seconds"
    return "#{json.length} Tenders were saved in #{Time.now - start} seconds"
  end

end