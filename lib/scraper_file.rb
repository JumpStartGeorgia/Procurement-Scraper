module ScraperFile

  def process
    start = Time.now
    # get the json file
    file_path = "#{Rails.root}/system/scraper.json"    
    file_data = File.open(file_path, "r") {|f| f.read()}
    
    if file_data
      puts " - found json file"
      json = JSON.parse(file_data)
      
      Tender.transaction do
        json.each do |item|
          tender = Tender.new

          # basic tender info
          tender.url_id = item["urlID"]
          tender.tender_type = item["tenderType"]
          tender.tender_registration_number = item["tenderRegistrationNumber"]
          tender.tender_status = item["tenderStatus"]
          tender.tender_announcement_date = item["tenderAnnouncementDate"]
          tender.bid_start_date = item["bidStartDate"]
          tender.bid_end_date = item["bidEndDate"]
          tender.estimated_value = item["estimatedValue"]
          tender.cpv_code = item["cpvCode"]
        
          # if the organization does not exist yet, add it
        

          if tender.valid?
            tender.save
          else
            Rails.logger.debug "***** tender was not valid: #{tender.errors} *****"
		        raise ActiveRecord::Rollback
          end
        end
      end
      
    end
    
    puts "###### total time = #{Time.now - start} seconds"
  end

end