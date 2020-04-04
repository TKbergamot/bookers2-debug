# frozen_string_literal: true

class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)
    if following.save
      flash[:success] = 'Following user success.'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'Cant following user.'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    user = User.find(params[:follow_id])
    following = current_user.unfollow(user)
    if following.destroy
      flash[:success] = 'User unfollowed.'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'Cant user unfollowed.'
      redirect_back(fallback_location: root_path)
    end
  end
end
