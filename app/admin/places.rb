ActiveAdmin.register Place do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :city_id, :name, :address, :latitude, :longitude, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def new
      @place = Place.new
      render "admin/places/new", layout: 'active_admin'
    end
    def create
      @place = Place.new(permitted_params[:place])
      if @place.save
        redirect_to admin_place_path(@place.id)
      else
        render "admin/places/new", layout: 'active_admin'
      end
    end
    def edit
      @place = Place.find(params[:id])
      render "admin/places/edit", layout: 'active_admin'
    end
    def update
      @place = Place.find(params[:id])
      if @place.update(permitted_params[:place])
        redirect_to admin_place_path(@place)
      else
        render "admin/places/edit", layout: 'active_admin'
      end
    end
  end

end
