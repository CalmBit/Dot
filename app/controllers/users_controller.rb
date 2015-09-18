class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(username: user_params[:username], email: user_params[:email], 'birthday(1i)' => user_params['birthday(1i)'], 'birthday(2i)' => user_params['birthday(2i)'],  'birthday(3i)' => user_params['birthday(3i)'])
    @user.construct_password(user_params[:password])
    @user.construct_validation
    respond_to do |format|
      if @user.save
        UserMailer.validation_email(@user).deliver_later
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def validate
    @user = User.find_by(email: params[:email])
    respond_to do |format|
      if @user == nil
        flash[:error] =  'Invalid email!'
        format.html {redirect_to url_for(:controller => :static, :action => :home)}
      elsif @user.validated
        flash[:error] = 'Account already activiated!'
        format.html {redirect_to url_for(:controller => :static, :action => :home)}
      elsif @user.validation_code != params[:code]
        flash[:error] = 'Invalid code!'
        format.html {redirect_to url_for(:controller => :static, :action => :home)}
      else
        @user.validated = true
        @user.save
        flash[:success] = 'Activated!'
        format.html {redirect_to url_for(:controller => :static, :action => :home)}
      end
    end
  end

  def login

  end

  def logout
    if @current_user
      session[:current_user_id] = nil
      flash[:success] = "Logged out!"
    else
      flash[:error] = "You're not logged in!"
    end
      redirect_to url_for(:controller => :static, :action => :home)
  end

  def login_attempt
    @user = User.find_by(username: params[:username])
    respond_to do |format|
      if @user == nil or not @user.password_valid?(params[:login_password])
        flash[:error] = "Username or password incorrect!"
        format.html {redirect_to url_for(:controler => :users, :action => :login)}
      else
        session[:current_user_id] = @user.id
        flash[:success] = "Login sucessful!"
        format.html {redirect_to url_for(:controller => :static, :action => :home)}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :birthday, :password)   
    end
end
