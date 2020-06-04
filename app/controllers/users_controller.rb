class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    if logged_in?
      @hashtag = current_user.hashtags.build  # form_with 用
      @hashtags = current_user.hashtags.order(id: :desc).page(params[:page])
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
    flash[:success] = 'ユーザを登録しました。'
    redirect_to @user
    else
    flash.now[:danger] = 'ユーザの登録に失敗しました。'
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
