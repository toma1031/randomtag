class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  
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
    # if current_user == @user
    # end
  end
  
  def update
    @user = User.find(params[:id])
    # if current_user == @user
      if @user.update_attributes(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render 'edit'
      end
    # end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  # ログイン済みユーザーかどうか確認
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
