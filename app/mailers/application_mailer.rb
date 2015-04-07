class ApplicationMailer < ActionMailer::Base
  default from: ENV['CONTACT_EMAIL_ADDRESS_WITH_NAME']
  layout 'mailer'

  def update_your_school_profile(school, new_password: nil)
    @school = school
    @new_password = new_password
    @current_period = ENV['CURRENT_PERIOD']

    mail to: "#{school.contact_name} <#{school.email}>",
         subject: %Q(Вашето участие в "Бъдешето е код", #{@current_period})
  end
end
