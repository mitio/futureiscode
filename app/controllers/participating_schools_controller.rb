class ParticipatingSchoolsController < ApplicationController
  def index
    @schools = School
      .where(confirmed_participation: true)
      .includes(town: {municipality: :state})
      .order('town_id, name')
  end
end
