class RootController < ApplicationController

  def index
    @recent_tenders = Tender.recent
#    @recent_bids = Bid.recent.includes()
    @tender_pie = Tender.tender_status_proportional
    gon.tender_pie_chart = @tender_pie
  end


end
