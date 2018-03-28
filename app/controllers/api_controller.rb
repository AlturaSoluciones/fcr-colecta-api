class ApiController < ActionController::API
  def email_lookup
    p = Person.find_by(email: params[:email])
    if p
      render json: p
    else
      render json: { new_user: true }
    end
  end
end
