module ScraperFile

  FILE_TENDER = "tenders.json"
  FILE_PROC_ENTITIES = "procuringEntities.json"

  def self.process
    start = Time.now
    msg = nil
    msgs = []
    I18n.locale = :en # do this so formating of floats and dates is correct when reading in json
    # get the json files
    tender_file_path = "#{Rails.root}/public/system/#{FILE_TENDER}"
    tender_file_data = File.open(tender_file_path, "r") {|f| f.read()}
    proc_ent_file_path = "#{Rails.root}/public/system/#{FILE_PROC_ENTITIES}"
    proc_ent_file_data = File.open(proc_ent_file_path, "r") {|f| f.read()}

    if tender_file_data && proc_ent_file_data
      Rails.logger.debug " - found json files"
      # take out extra ',' at end of data
      json_tender = JSON.parse(tender_file_data.gsub("},]", "}]"))
      json_proc_ent = JSON.parse(proc_ent_file_data.gsub("},]", "}]"))

      Tender.transaction do
        # remove old entries
        Tender.delete_all
        Organization.delete_all

        json_tender.each_with_index do |item, index|
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

          # find the procurer json record
          procurrer = json_proc_ent.select{|x| x["urlID"] == item["procuringEntityID"]}
          if procurrer && !procurrer.empty?
            # if the procurer does not exist in organization yet, add it
            organization = Organization.find_by_url_id(procurrer.first["urlID"])
            if !organization
              organization = Organization.create(
                :url_id => procurrer.first["urlID"],
                :label_id => procurrer.first["OrgID"],
                :name => procurrer.first["Name"],
                :country => procurrer.first["Country"]
              )
            end
            tender.procurring_entity_id = organization.id
          else
            Rails.logger.debug "***** procuring entity was not found for this tender record #{index} *****"
		        msgs << [tender.url_id, item["procuringEntityID"]]
#		        raise ActiveRecord::Rollback
#		        break
          end

          if tender.valid?
            tender.save
          else
            Rails.logger.debug "***** tender was not valid: #{tender.errors} *****"
		        msg = "ERROR: An error occurred while saving json record #{index}"
		        raise ActiveRecord::Rollback
		        break
          end
        end
      end

    end

    Rails.logger.debug "###### total time = #{Time.now - start} seconds"
    msg = "#{json_tender.length} Tenders were saved in #{Time.now - start} seconds" if msg.nil?
    Rails.logger.debug "msg = #{msg}"
    Rails.logger.debug "tenders with unfound proc entities = #{msgs}"
    return msg
  end

end
