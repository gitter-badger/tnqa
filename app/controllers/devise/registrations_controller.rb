# controllers/users/registrations_controller.rb
# class RegistrationsController < Devise::RegistrationsController
 
#   before_filter :configure_permitted_parameters
 
#   protected
 
#   # my custom fields are :name
#   def configure_permitted_parameters
#     devise_parameter_sanitizer.for(:sign_up) do |u|
#       u.permit(:name,
#         :email, :password, :password_confirmation)
#     end
#     devise_parameter_sanitizer.for(:account_update) do |u|
#       u.permit(:name,
#         :email, :password, :password_confirmation, :current_password)
#     end
#   end
 
# end

class RegistrationsController < Devise::RegistrationsController
 
  private
 
  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
 
  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end