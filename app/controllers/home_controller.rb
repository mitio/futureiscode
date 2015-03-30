class HomeController < ApplicationController
  def index
    @companies = Company.where(pledged_support: true)
  end
end
