module ApplicationHelper
  def scroll_to(text, section, options = {})
    options[:class] ||= ''
    options[:class] << ' smooth-scroll'

    link_to text, "##{section}", options
  end
end
