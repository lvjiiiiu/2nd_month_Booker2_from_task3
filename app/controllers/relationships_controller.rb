class RelationshipsController < ApplicationController
  
  def create #フォローする Userモデルで定義したfollowメソッド
      current_user.follow(params[:user_id])
      redirect_to request.referer #遷移前のURLを取得してリダイレクト
  end
  
  def destroy #フォローを外す　Userモデルで定義したunfollowメソッド
      current_user.unfollow(params[:user_id])
      redirect_back(fallback_location: root_path)
  end
  
  def follower #follower一覧
      user = User.find(params[:user_id])
      @users = user.follower_user
      # .follower_userメソッド ：Userモデルで定義済
  end
  
  def followed #followed一覧
      user = User.find(params[:user_id])
      @users = user.following_user
      # .follower_userメソッド ：Userモデルで定義済
  end
end
