class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  after_action :verify_authorized, :except => :index, unless: :without_pundit?

  protect_from_forgery with: :exception

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def without_pundit?
    defined? :device_controller?
  end

  def after_sign_up_path_for(questions)
    questions_path(questions)
  end

  private

  def user_not_authorized
    respond_to do |format|
      format.html {
        flash[:error] = "You are not authorized to perform this action."
        redirect_to(request.referrer || root_path)
      }
      format.js {render text: "alert('У вас недостаточно репутационных баллов');" }
    end
  end
end
