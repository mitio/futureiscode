class Speaker < ActiveRecord::Base
  include Gravatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :company
  has_many :events

  validates :name, presence: true

  def person_name
    name
  end

  def email_with_name
    "#{name} <#{email}>"
  end

  def company_or_other
    company or other_company
  end
end
