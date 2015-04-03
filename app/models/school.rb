class School < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :town

  validates :name, presence: true, uniqueness: {scope: :town_id}
  validates :town_id, presence: true
  validates :address, presence: true
  validates :contact_name, presence: true
  validates :email, email: true, allow_blank: true

  serialize :details

  delegate :state, :municipality, to: :town
end
