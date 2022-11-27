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

  def link_to_map_with_preview_for(school, width: 800, height: 300, zoom: 15, **params)
    lat, lng = school.latitude, school.longitude
    external_map_url = "https://www.openstreetmap.org/?mlat=#{lat}&mlon=#{lng}#map=#{zoom}/#{lat}/#{lng}"

    # Documentation: https://open.mapquestapi.com/staticmap/
    map_params = {
      key: ENV['MAPQUEST_API_KEY'],
      size: "#{width},#{height}",
      zoom: zoom,
      center: "#{lat},#{lng}",
      imagetype: 'jpg',
      pois: "blue_1,#{lat},#{lng}",
    }.merge(params)

    static_map_image_url = "https://open.mapquestapi.com/staticmap/v4/getmap?#{map_params.to_param}"

    link_to external_map_url, target: '_blank', title: 'Вижте по-голяма карта', class: 'map' do |variable|
      image_tag static_map_image_url, alt: school.full_address, width: width, height: height
    end
  end

  def event_host_for?(event)
    school_signed_in? && current_school == event.school
  end
end
