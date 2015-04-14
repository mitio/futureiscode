class ParticipatingSchoolsController < ApplicationController
  def index
    @schools = School.participating.with_location_info.order('town_id, name')
  end

  def show
    @school = School.participating.find(params[:id])
    @school_events = events_scope_for(@school).newest_first
    @pending_events_count = @school.pending_events.count(:all)
  end

  private

  def events_scope_for(school)
    if current_school == school
      school.events
    else
      school.events.approved
    end
  end
end
