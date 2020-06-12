class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    if logged_in?
      @hashtag = current_user.hashtags.build  # form_with 用
      @hashtags = current_user.hashtags.order(id: :desc).page(params[:page])
      if params[:hashtag].nil?
        # # mySQL用
        # @randomtags = current_user.hashtags.order("RAND()").limit(28)
        # # Postgresql & Heroku用
        rand = Rails.env.production? ? "RANDOM()" : "rand()"
        @randomtags = current_user.hashtags.order(rand).limit(28)
        # # Ajax
        #   respond_to do |format|
        #     format.html
        #     format.js
        #   end
        # # Ajax
      else
        # mySQL用
        # @randomtags = current_user.hashtags.order("RAND()").limit(params[:hashtag][:hashtags])
        # # Postgresql & Heroku用
        rand = Rails.env.production? ? "RANDOM()" : "rand()"
        @randomtags = current_user.hashtags.order(rand).limit(params[:hashtag][:hashtags])
        # # Ajax
        #   respond_to do |format|
        #     format.html
        #     format.js
        #   end
        # # Ajax
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
