class RootController < ApplicationController
  require 'scraper_file'

  def index
    @recent_tenders = Tender.recent
    @recent_bids = Bid.recent
    @recent_orgs = Organization.recent
    gon.tender_pie_chart = Tender.tender_status_proportional
    gon.top_cpv_estimated_values = Tender.top_cpv_estimated_values(10)
  end

  def process_json
    msg = ScraperFile.process
    redirect_to root_path, notice: msg
  end

end
