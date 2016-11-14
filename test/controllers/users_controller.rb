class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def index
  	 @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
end  