class ParticipatingSchoolsController < ApplicationController
  def index
    @schools = School
      .participating
      .includes(town: {municipality: :state})
      .order('town_id, name')
  end

  def show
    @school = School.participating.find(params[:id])
  end
end
