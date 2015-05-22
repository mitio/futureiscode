class HomeController < ApplicationController
  def index
    @companies = Company.where(pledged_support: true)
    @participating_schools_count = School.participating.size
    @events = Event.all
  end
end
