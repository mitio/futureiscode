class State < ActiveRecord::Base
  include AlphabeticalOrder

  has_many :municipalities
  has_many :towns, through: :municipalities

  validates :code, presence: true, uniqueness: true
  validates :name, presence: true
end
