module ScraperFile

  def process
    start = Time.now
    # get the json file
    file_path = "#{Rails.root}/system/scraper.json"    
    file_data = File.open(file_path, "r") {|f| f.read()}
    
    if file_data
      puts " - found json file"
      json = JSON.parse(file_data)
      
      
      
    end
    
    puts "###### total time = #{Time.now - start} seconds"
  end

end