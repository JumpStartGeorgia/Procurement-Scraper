class TendersController < ApplicationController
  def index
    @tenders = Tender.paginate(:page => params[:page])
  end

  def show
    @tender = Tender.find(params[:id])
  end

end
