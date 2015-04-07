class Town < ActiveRecord::Base
  belongs_to :municipality

  validates :kind, presence: true
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :municipality_id, presence: true

  delegate :state, to: :municipality

  def full_name
    components = [name_with_kind]
    components << I18n.t('teritorrial_divisions.municipality', name: municipality.name) if municipality.name != name
    components << I18n.t('teritorrial_divisions.state', name: state.name) if state.name != name && state.name != municipality.name

    components.join(', ')
  end

  def name_with_kind
    "#{kind} #{name}"
  end
end
