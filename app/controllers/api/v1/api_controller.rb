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
      render json: city.places.available(params[:schedule_id])
    end

    def schedules
      render json: Schedule.all
    end

    def create_location
      location = Location.create(location_params)
      if location.persisted?
        render json: { success: true, location: location }
      else
        render json: { success: false, errors: location.errors.full_messages }
      end
    end

    def store_friends
      Person.transaction do
        Person.create!(friends_params[:friends])
      end

      render json: { success: true, message: 'Todos los amigos almacenados con exito'}

    rescue
      render json: { success: false, message: 'Alguno de los amigos no pudo ser almacenado'}
    end

    def get_friends
      render json: Person.find(params[:person_id]).friends
    end

    def confirm_person
      person = Person.find_by(confirmation_token: params[:token])
      person.confirm!
      render json: { success: person.confirmed?, person: person }
    rescue
      render json: { success: false }
    end

    def get_settings
      render json: Setting.all.map{ |setting| [setting.name, setting.value] }.to_h
    end

    private
    def person_params
      params.permit(:firstname, :lastname, :identifier, :birthday, :phone, :cellphone, :email, :gender)
    end

    def friends_params
      params.permit(friends: %i{firstname lastname email cellphone invited_by_id})
    end

    def location_params
      params.permit(:place_id, :schedule_id, :responsible_id)
    end

  end
end