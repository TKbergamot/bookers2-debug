# frozen_string_literal: true


class ChatsController < ApplicationController

  before_action :authenticate_user!, only: [:create]



  def create

    if UserRoom.where(user_id: current_user.id, room_id: params[:chat][:room_id]).present?

      @chat = Chat.create(params.require(:chat).permit(:user_id, :content, :room_id).merge(user_id: current_user.id))

    else

      redirect_back(fallback_location: root_path)

    end

  end

end
