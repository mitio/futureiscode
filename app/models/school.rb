class School < ActiveRecord::Base
  include DetailsHash

  belongs_to :town
  has_many :events

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

  scope :participating, -> { where(confirmed_participation: true) }
  scope :in_alphabetical_order, -> { order(arel_table[:name].asc) }
  scope :with_location_info, -> { includes(town: {municipality: :state}) }

  geocoded_by :full_address
  after_validation :geocode, if: :full_address_changed?

  def person_name
    contact_name
  end

  def name_with_location
    "#{name}, #{town.full_name}"
  end

  def full_address
    "#{town.full_name}, #{address}"
  end

  def full_address_changed?
    town_id_changed? || address_changed?
  end
end
