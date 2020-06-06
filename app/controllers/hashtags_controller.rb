class HashtagsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def create
    @hashtag = current_user.hashtags.build(hashtag_params)
    if @hashtag.save
      # flash[:success] = 'hashtagを投稿しました。'
      redirect_to users_url
    else
      @hashtags = current_user.hashtags.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'hashtagの投稿に失敗しました。'
      redirect_to users_url
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
