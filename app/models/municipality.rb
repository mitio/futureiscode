class Municipality < ActiveRecord::Base
  belongs_to :state
  has_many :towns

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :state_id, presence: true
end
