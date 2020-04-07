# frozen_string_literal: true



class UsersController < ApplicationController

  before_action :authenticate_user!

  before_action :baria_user, only: [:update]



  def show

    @user = User.find(params[:id])

    @books = @user.books

    @current_user_room = UserRoom.where(user_id: current_user.id)

    @user_room = UserRoom.where(user_id: @user.id)

    if @user.id == current_user.id

    else

      @current_user_room.each do |cu|

        @user_room.each do |u|

          if cu.room_id == u.room_id

            @isRoom = true

            @roomId = cu.room_id

          end

        end

      end

      if @isRoom

      else

        @room = Room.new

        @user_room = UserRoom.new

      end

    end

    @book_comment = BookComment.new

    address = '東京都'

    if @user == current_user

      if @user.address_city.present?

        address = @user.address_city + @user.address_street

      end

    end

    results = Geocoder.search(address)

    @latlng = results.first.coordinates

    @key = ENV['API_KEY']

  end



  def index

    @users = User.all

    @book = Book.new

   end



  def edit

    @user = User.find(params[:id])

    redirect_to user_path(current_user) if @user != current_user

  end



  def update

    @user = User.find(params[:id])

    if @user == current_user

      if @user.update(user_params)

        redirect_to user_path, notice: 'successfully updated user!'

      else

        render :edit

      end

    else redirect_to user_path(current_user)

    end

  end



  def following

    @title = 'Following'

    @user = User.find(params[:id])

    @users = @user.followings.all

    render 'show_follow'

  end



  def followers

    @title = 'Followers'

    @user = User.find(params[:id])

    @users = @user.followers.all

    render 'show_follow'

  end



  private



  def user_params

    params.require(:user).permit(:name, :introduction, :profile_image)

  end



  def baria_user

    unless params[:id].to_i == current_user.id

      redirect_to user_path(current_user)

  end

end

end
