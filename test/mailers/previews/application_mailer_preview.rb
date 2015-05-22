class ApplicaitonMailerPreview < ActionMailer::Preview
  def update_your_school_profile
    ApplicationMailer.update_your_school_profile(School.last)
  end

  def update_your_school_profile_with_new_password
    ApplicationMailer.update_your_school_profile(School.last, new_password: 'newpassword')
  end

  def new_event
    ApplicationMailer.new_event(Event.last)
  end

  def event_approved
    ApplicationMailer.event_approved(Event.last)
  end

  def event_reverted_to_pending
    ApplicationMailer.event_reverted_to_pending(Event.last)
  end

  def create_an_event
    ApplicationMailer.create_an_event(Speaker.confirmed.no_events.first)
  end
end
