class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    render 'edit', locals: { user: @user }
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show
    return unless params[:id] == 'sign_out'

    sign_out_and_redirect
  end

  private

  def sign_out_and_redirect
    sign_out current_user
    redirect_to splash_path
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
