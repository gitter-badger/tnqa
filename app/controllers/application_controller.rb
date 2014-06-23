class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  after_action :verify_authorized, :except => :index
  protect_from_forgery with: :exception
 
  rescue_from CanCan::AccessDenied do
  	render text: 'Доступ запрещен'
  end

  def after_sign_up_path_for(questions)
    questions_path(questions)
  end

   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

end
