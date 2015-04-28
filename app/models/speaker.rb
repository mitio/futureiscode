class Speaker < ActiveRecord::Base
  include Gravatar

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  belongs_to :company, counter_cache: true
  has_many :events

  validates :name, presence: true

  after_save :update_company_events_count

  def person_name
    name
  end

  def email_with_name
    "#{name} <#{email}>"
  end

  def company_or_other
    company or other_company
  end

  def company_name
    if company
      company.name
    elsif other_company.present?
      other_company
    end
  end

  def update_company_events_count
    company.update_events_count if company

    if company_id_changed? && company_id_was
      Company.find_by_id(company_id_was).try(:update_events_count)
    end
  end
end
