require 'font-awesome-rails'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate
  rescue_from ActiveRecord::RecordNotFound, :with => :handle_missingaction
  rescue_from ActionView::MissingTemplate, :with => :handle_missingaction
  rescue_from ActionController::RoutingError, :with => :handle_missingaction


  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  private
    def authenticate
    	unless session[:current_user_id]
    	else
    		@current_user = User.find(session[:current_user_id])
                 if not @current_user.validated
                    flash[:warning] =  @current_user.username + ", you still haven't validated your email! Check your inbox for your validation link."
                end
    	end
    end

    def handle_missingaction
      render :status => :not_found, :action => 'fourohfour'
    end

end
