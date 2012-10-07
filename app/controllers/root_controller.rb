class RootController < ApplicationController
  require 'scraper_file'

  def index
    @recent_tenders = Tender.recent
#    @recent_bids = Bid.recent.includes()
#    @tender_pie = Tender.tender_status_proportional
#    gon.tender_pie_chart = @tender_pie

    gon.top_cpv_estimated_values = Tender.top_cpv_estimated_values(10)
  end

  def process_json
    msg = ScraperFile.process
    redirect_to root_path, notice: msg
  end

end
