require 'u2f'

class U2FRegistrationsController < ApplicationController
  before_action :set_u2_f_registration, only: [:show, :edit, :update, :destroy]
  before_action :check_if_user


  # GET /u2_f_registrations
  # GET /u2_f_registrations.json
  def index
    @u2_f_registrations = U2FRegistration.all
  end

  # GET /u2_f_registrations/1
  # GET /u2_f_registrations/1.json
  def show
  end

  # GET /u2_f_registrations/new
  def new
    @registration_requests = u2f.registration_requests

    session[:challenges] = @registration_requests.map(&:challenge)
    
    key_handles = U2FRegistration.pluck(:key_handle)
    @sign_requests = u2f.authentication_requests(key_handles)
  end

  # GET /u2_f_registrations/1/edit
  def edit
  end

  # POST /u2_f_registrations
  # POST /u2_f_registrations.json
  def create
    response = U2F::RegisterResponse.load_from_json(params[:response])

    reg = begin
        u2f.register!(session[:challenges], response)
    rescue U2F::Error => e
        return "Unable to register: <%= e.class.name %>"
    ensure
        session.delete(:challenges)
    end

    @u2_f_registration = U2FRegistration.new(certificate: reg.certificate,
					     key_handle:  reg.key_handle,
					     public_key:  reg.public_key,
					     counter:     reg.counter,
					     user_id:     session[:current_user_id])
    respond_to do |format|
      if @u2_f_registration.save
        format.html { redirect_to @u2_f_registration, notice: 'U2 f registration was successfully created.' }
        format.json { render :show, status: :created, location: @u2_f_registration }
      else
        format.html { render :new }
        format.json { render json: @u2_f_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /u2_f_registrations/1
  # PATCH/PUT /u2_f_registrations/1.json
  def update
    respond_to do |format|
      if @u2_f_registration.update(u2_f_registration_params)
        format.html { redirect_to @u2_f_registration, notice: 'U2 f registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @u2_f_registration }
      else
        format.html { render :edit }
        format.json { render json: @u2_f_registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /u2_f_registrations/1
  # DELETE /u2_f_registrations/1.json
  def destroy
    @u2_f_registration.destroy
    respond_to do |format|
      format.html { redirect_to u2_f_registrations_url, notice: 'U2 f registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

     def u2f
                @u2f ||= U2F::U2F.new(request.base_url)
     end

    def check_if_user
	if not session[:current_user_id]
		respond_to do |format|
			format.html { redirect_to url_for(:controller => :users, 
							  :action => :login)}
		end
	end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_u2_f_registration
      @u2_f_registration = U2FRegistration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def u2_f_registration_params
      params[:u2_f_registration]
    end
end
