class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  rescue_from CanCan::AccessDenied do
  	render text: 'Доступ запрещен'
  end

  def after_sign_up_path_for(questions)
    questions_path(questions)
  end

end
