module Api::V1
  class ApiController < ActionController::API
    def email_lookup
      p = Person.find_by(email: params[:email])
      if p
        render json: p
      else
        render json: { new_user: true }
      end
    end

    def create_person
      p = Person.create(person_params)
      if p.persisted?
        render json: { success: true, person: p }
      else
        render json: { success: false, errors: p.errors.full_messages }
      end
    end

    def cities
      render json: City.all
    end

    def places
      city = City.find(params[:id])
      render json: city.places.where(status: params[:status])
    end

    private
    def person_params
      params.permit(:firstname, :lastname, :identifier, :birthday, :phone, :cellphone, :email)
    end
  end
end