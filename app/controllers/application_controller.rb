require 'font-awesome-rails'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  force_ssl unless Rails.env.development?
  before_action :authenticate
  before_filter :announcement_check
  rescue_from ActiveRecord::RecordNotFound, :with => :handle_missingaction
  rescue_from ActionView::MissingTemplate, :with => :handle_missingaction
  rescue_from ActionController::RoutingError, :with => :handle_missingaction


  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  def annquash!
    if not request.referer
      raise_not_found!
    else
      cookies[:annquash] = DateTime.now
       flash[:succcess] = "Cleared announcements!"
      redirect_to request.referer
    end
  end

  private

    def announcement_check
        if not cookies[:annquash] 
          @announcements = Announcement.where("starts_at <= :time AND ends_at >= :time", {time: DateTime.now})
        else
          @announcements = Announcement.where("starts_at <= :time AND ends_at >= :time AND starts_at >= :annquash", {time: DateTime.now, annquash: Time.parse(cookies[:annquash]).getutc})
        end
        if @announcements.size == 0
          @announcements = nil
        end
    end

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
