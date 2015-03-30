class Company < ActiveRecord::Base
  include Sluggable

  validates :name, presence: true, uniqueness: true

  has_attached_file :logo, styles: {
    large:      '600x600>',
    medium:     '300x300>',
    small:      '100x100>',
    small_crop: '100x100#',
  }, url: '/system/:class/:attachment/:id_partition/:style/:param.:extension'
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/
end
