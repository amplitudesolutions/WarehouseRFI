class DashboardController < ApplicationController
  def index
  	@iso = Material.select(:isometric_number).distinct.order(isometric_number: :asc)
  end

  def search
  end
end
