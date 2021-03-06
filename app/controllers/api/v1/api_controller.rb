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
      render json: City.active
    end

    def places
      city = City.find(params[:id])
      render json: city.places.available(params[:schedule_id])
    end

    def schedules
      render json: Schedule.enabled
    end

    def create_location
      location = Location.create(location_params)
      if location.persisted?
        render json: { success: true, location: location }
      else
        render json: { success: false, errors: location.errors.full_messages }
      end
    end

    def join_location
      location = Location.find(params[:location_id])
      person = Person.find(params[:person_id])
      person.invited_by = location.responsible
      if person.save
        person.send_invitation
        # TODO: Bad place to put it...
        # Should be change to model
        FriendsMailer.new_member_joined(person, person.invited_by).deliver
        render json: { success: true, location: location }
      else
        render json: { success: false, errors: person.errors.full_messages }
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

    def delete_friend
      if Person.find(params[:id]).friends.find(params[:friend_id]).destroy
        render json: { success: true, message: 'Amigo eliminado' }
      else
        render json: { success: false, message: 'No se puedo eliminar amigo' }
      end
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

    def available_places
      city = City.find(params[:cityId])

      render json: city.locations.available_places(params[:scheduleId])
    end


    private
    def person_params
      params.permit(:firstname, :lastname, :identifier, :birthday, :phone, :cellphone, :email, :gender, :is_joining)
    end

    def friends_params
      params.permit(friends: %i{firstname lastname email cellphone invited_by_id})
    end

    def location_params
      params.permit(:place_id, :schedule_id, :responsible_id)
    end

  end
end
