class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.order_by_name.paginate(:page => params[:page])
  end

  def show
    @organization = Organization.find(params[:id])
  end

end
