class School < ActiveRecord::Base
  include DetailsHash

  belongs_to :town

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  details_attribute :visit_dates
  details_attribute :remarks
  details_attribute :disciplines,         any_of: Options.for('disciplines').keys.map(&:to_s)
  details_attribute :available_equipment, any_of: Options.for('available_equipment').keys.map(&:to_s)
  details_attribute :meetup_options,      one_of: Options.for('meetup_options').keys.map(&:to_s)

  delegate :state, :municipality, to: :town

  validates :name, presence: true, uniqueness: {scope: :town_id}
  validates :town_id, presence: true
  validates :address, presence: true
  validates :contact_name, presence: true
  validates :email, email: true, allow_blank: true
  validates :visit_dates, presence: true
  validates :disciplines, presence: true
  validates :meetup_options, presence: true
  validates :confirmed_participation, acceptance: {accept: true}, if: :new_record?

  def person_name
    contact_name
  end
end
