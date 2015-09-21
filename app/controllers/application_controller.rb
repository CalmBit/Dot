require 'font-awesome-rails'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate

  def authenticate
  	unless session[:current_user_id]
  	else
  		@current_user = User.find(session[:current_user_id])
               if not @current_user.validated
                  flash[:warning] =  @current_user.username + ", you still haven't validated your email! Check your inbox for your validation link."
              end
  	end
  end
end
