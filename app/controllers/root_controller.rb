class RootController < ApplicationController
  require 'scraper_file'

  def index
    
  end

  def process_json
    msg = ScraperFile.process
    redirect_to root_path, notice: msg
  end

end
