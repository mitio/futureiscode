class Event < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :school

  has_attached_file :cover_image, styles: {
    large:  '1600x400>',
    medium: '1200x300>',
    small:  '800x200>',
    tiny:   '400x100>',
  }

  validates :speaker_id, presence: true
  validates :school_id, presence: true
  validates :date, presence: true
  validates :details, presence: true
  validates :cover_image, attachment_size: {less_than: 2.megabytes},
                          attachment_content_type: {content_type: /\Aimage\/.*\Z/},
                          dimensions: {min_width: 800, min_height: 100}

  scope :newest_first, -> { order(arel_table[:date].desc) }
  scope :approved, -> { where(approved: true) }

  def name_or_default
    name or defaut_name
  end

  def default_name
    I18n.t('default_event_name', date: l(date))
  end
end
