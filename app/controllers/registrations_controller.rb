class RegistrationsController < Devise::RegistrationsController
  def new
    @municipalities = Municipality.order('name ASC')
    set_towns
    super
  end

  def update_towns
    set_towns
    respond_to do |format|
      format.js
    end
  end

  private
    def set_towns
      if params[:municipality_id].present?
        @towns = Town.where('municipality_id = ?', params[:municipality_id]).order('name ASC').includes(municipality: :state)
      else
        @towns = Town.where('1 != 1')
      end
    end
end
