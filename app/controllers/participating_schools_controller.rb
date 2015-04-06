class ParticipatingSchoolsController < ApplicationController
  def index
    @schools = School.participating.with_location_info.order('town_id, name')
  end

  def show
    @school = School.participating.find(params[:id])
  end
end
