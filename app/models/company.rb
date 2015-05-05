class Company < ActiveRecord::Base
  include Sluggable
  include AlphabeticalOrder

  has_many :speakers

  validates :name, presence: true, uniqueness: true

  has_attached_file :logo, styles: {
    large:      '600x600>',
    medium:     '300x300>',
    small:      '100x100>',
    small_crop: '100x100#',
  }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  def update_events_count
    update_attribute :events_count, speakers.sum(:events_count)
  end
end
