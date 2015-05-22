class ApplicationMailer < ActionMailer::Base
  default from: ENV['CONTACT_EMAIL_ADDRESS_WITH_NAME']
  layout 'mailer'

  def update_your_school_profile(school, new_password: nil)
    @school = school
    @new_password = new_password
    @current_period = ENV['CURRENT_PERIOD']

    mail to: school.email_with_name,
         subject: %Q(Вашето участие в "Бъдешето е код", #{@current_period})
  end

  def new_event(event)
    @event   = event
    @school  = event.school
    @speaker = event.speaker

    mail to: @school.email_with_name,
         subject: "Ново събитие от #{@speaker.name} във вашето учебно заведение очаква одобрение"
  end

  def event_approved(event)
    @event   = event
    @school  = event.school
    @speaker = event.speaker

    mail to: @speaker.email_with_name, subject: "Одобрено събитие #{@event.name_or_default}"
  end

  def event_reverted_to_pending(event)
    @event   = event
    @school  = event.school
    @speaker = event.speaker

    mail to: @speaker.email_with_name, subject: "Събитието #{@event.name_or_default} е върнато за преглед"
  end

  def create_an_event(speaker)
    @speaker             = speaker
    @schools_with_events = School.with_events
    @potential_schools   = School.participating.up_to_date.no_events
    @events              = Event.all

    mail to: @speaker.email_with_name, subject: 'Все още имате време да посетите училище по линия на Бъдещето е код'
  end
end
