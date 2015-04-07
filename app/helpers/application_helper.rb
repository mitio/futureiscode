require_dependency 'markup'

module ApplicationHelper
  def scroll_to(text, section, options = {})
    options[:class] ||= ''
    options[:class] << ' smooth-scroll'

    link_to text, "##{section}", options
  end

  def member_signed_in?
    school_signed_in? or speaker_signed_in?
  end

  def hash_to_collection_options(hash)
    hash.map { |id, label| [label, id] }
  end

  def markup(text)
    Markup.format text
  end

  def link_to_company(company)
    if company.is_a? Company
      name_or_logo =
        if company.logo.present?
          image_tag(company.logo.url(:small), alt: company.name, title: company.name)
        else
          company.name
        end

      if company.url.present?
        link_to name_or_logo, company.url, rel: 'nofollow', target: '_blank', class: 'company'
      else
        content_tag :span, name_or_logo, class: 'company'
      end
    elsif company
      content_tag :span, company, class: 'company other'
    end
  end
end
