class RootController < ApplicationController

  def index
    @recent_tenders = Tender.recent
#    @recent_bids = Bid.recent.includes()
  end


end
