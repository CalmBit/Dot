require 'u2f'

class U2FAuthenticationsController < ApplicationController

def new
  # Fetch existing Registrations from your db
  key_handles = U2FRegistration.where(:user_id => session[:temporary_user_id]).pluck(:key_handle)
  return 'Need to register first' if key_handles.empty?

  # Generate SignRequests
  @sign_requests = u2f.authentication_requests(key_handles)

  # Store challenges. We need them for the verification step
  session[:challenges] = @sign_requests.map(&:challenge)
end	

def create
  response = U2F::SignResponse.load_from_json(params[:response])

  registration = U2FRegistration.where(key_handle: response.key_handle).first
  return 'Need to register first' unless registration

  begin
    u2f.authenticate!(session[:challenges], response,
                      Base64.decode64(registration.public_key),
                      registration.counter)
  rescue U2F::Error => e
    return "Unable to authenticate: <%= e.class.name %>"
  ensure
    session.delete(:challenges)
  end

  session[:current_user_id] = session[:temporary_user_id]
  session.delete(:temporary_user_id)
 

  registration.update(counter: response.counter)

  respond_to do |format|
	format.html {redirect_to url_for(:controller => :static, :action => :home)}
  end
end

 private

	def u2f
  		@u2f ||= U2F::U2F.new(request.base_url)
	end
end
