class Api::RegistrationsController < Devise::RegistrationsController
  protect_from_forgery with: :null_session
  respond_to :json

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: { status: 'success', message: 'Signed up successfully.', user: resource }, status: :ok
    else
      render json: { status: 'error', message: resource.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end
end
