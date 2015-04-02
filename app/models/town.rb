class Town < ActiveRecord::Base
  belongs_to :municipality

  validates :kind, presence: true
  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
  validates :municipality_id, presence: true

  delegate :state, to: :municipality

  def full_name
    "#{kind} #{name}, #{municipality.name}, #{state.name}"
  end
end
