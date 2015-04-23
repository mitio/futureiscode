class Event < ActiveRecord::Base
  include DeletableAttachment

  belongs_to :speaker, counter_cache: true
  belongs_to :school, counter_cache: true

  has_attached_file :cover_image, styles: {
    large:  '1600x400>',
    medium: '1200x300>',
    small:  '800x200>',
    tiny:   '400x100>',
  }

  delegate :latitude, :longitude, :geocoded?, to: :school
  delegate :update_company_events_count, to: :speaker

  validates :speaker_id, presence: true
  validates :school_id, presence: true
  validates :date, presence: true
  validates :details, presence: true
  validates :cover_image, attachment_size: {less_than: 2.megabytes},
                          attachment_content_type: {content_type: /\Aimage\/.*\Z/},
                          dimensions: {min_width: 800, min_height: 100}
  validate  :school_does_not_change, if: :persisted?

  after_save :update_company_events_count

  scope :newest_first, -> { order(arel_table[:date].desc) }
  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }

  deletable_attachment :cover_image

  def name_or_default
    if name.present?
      name
    else
      default_name
    end
  end

  def name_or_school_name
    if name.present?
      name
    else
      school.name
    end
  end

  def default_name
    I18n.t('default_event_name', date: I18n.l(date), school: school.name)
  end

  def full_name_with_date
    "#{localized_date}, #{school.town.full_name} – #{name_or_school_name}"
  end

  def short_description
    description =
      if name.present?
        %Q(#{name} – събитие от "Бъдещето е код", провеждащо се на #{localized_date} в #{school.name_with_location})
      else
        %Q(Събитие от "Бъдещето е код", провеждащо се на #{localized_date} в #{school.name_with_location})
      end

    description << ", организирано от #{speaker.company_name}" if speaker.company_name.present?
    description << ", с лектор #{speaker.name}."

    description
  end

  def localized_date
    I18n.l date, format: '%d %B %Y г.'
  end

  def pending?
    !approved?
  end

  def as_json(options = {})
    {
      id: id,
      latitude: latitude,
      longitude: longitude,
      name: full_name_with_date,
    }
  end

  private

  def school_does_not_change
    if school_id_changed?
      errors.add :school_id, :cannot_change
    end
  end
end
