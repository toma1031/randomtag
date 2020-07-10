class HashtagsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @hashtag = current_user.hashtags.build(hashtag_params)
    if @hashtag.save
      # flash[:success] = 'hashtagを投稿しました。'
      redirect_to root_url
    else
      # @hashtags = current_user.hashtags.order(id: :desc).page(params[:page])
      @hashtags = current_user.hashtags.order(id: :desc)
      flash[:danger] = 'Please input tag using more than one character but less than 30 characters. No blank and no duplicate tag.'
      redirect_to root_url
    end
  end

  def destroy
    @hashtag.destroy
    # flash[:success] = 'hashtagを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  
  def show
    
  end
  
  

  private

  def hashtag_params
    params.require(:hashtag).permit(:content)
  end
  
  def randomtag_params
    params.require(:randomtag).permit(:content)
  end

  def correct_user
    @hashtag = current_user.hashtags.find_by(id: params[:id])
    unless @hashtag
      redirect_to root_url
    end
  end
end
