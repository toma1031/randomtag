class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :correct_user,   only: [:edit, :update]
  
  def index
    if logged_in?
      @hashtag = current_user.hashtags.build  
      @hashtags = current_user.hashtags.order(id: :desc)
      if params[:hashtag].nil?
        rand = Rails.env.production? ? "RANDOM()" : "rand()"
        @randomtags = current_user.hashtags.order(rand).limit(28)
      else
        rand = Rails.env.production? ? "RANDOM()" : "rand()"
        @randomtags = current_user.hashtags.order(rand).limit(params[:hashtag][:hashtags])
      end
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
    flash[:success] = 'Succeeded!'
    redirect_to @user
    else
    flash.now[:danger] = 'Failed'
    render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Succeed to delete an account!"
    redirect_to signup_path
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
end
