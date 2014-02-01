class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find_by(name: params[:name])
  end
end
