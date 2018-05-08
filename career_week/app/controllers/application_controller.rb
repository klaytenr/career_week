class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :check_log_in

  protect_from_forgery with: :exception

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  private

  def check_log_in
    if session[:user_id]
      if session[:code]
        if session[:code] != Code.last().content
          print session[:code]
          print 'session'
          print Code.last()
          print 'code'
          redirect_to "/code"
        end
      else 
        redirect_to '/code'
      end 
    else
      redirect_to "/"
    end
  end 

end
