class ApplicaitonMailerPreview < ActionMailer::Preview
  def update_your_school_profile
    ApplicationMailer.update_your_school_profile(School.last)
  end

  def update_your_school_profile_with_new_password
    ApplicationMailer.update_your_school_profile(School.last, new_password: 'newpassword')
  end
end
