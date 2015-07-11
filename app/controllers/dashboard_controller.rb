class DashboardController < ApplicationController
  def index
  	@iso = Material.select(:isometric_number).distinct.order(isometric_number: :asc)
  	@types = Type.all
  	@requisition = Requisition.new
  end
end
