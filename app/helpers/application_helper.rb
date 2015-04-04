module ApplicationHelper
  def scroll_to(text, section, options = {})
    options[:class] ||= ''
    options[:class] << ' smooth-scroll'

    link_to text, "##{section}", options
  end

  def member_signed_in?
    school_signed_in?
  end
end
