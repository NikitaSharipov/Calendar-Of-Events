class UsersController < ApplicationController

  def show
    if current_user == User.where(id: params[:id]).first
      @user = current_user
    else
      redirect_to root_path, notice: 'You don not have premision to enter this page'
    end
  end

  def update
    if current_user.id == params[:id].to_i
      if current_user.update(user_params.reject{|_, v| v.blank?})
        bypass_sign_in current_user
        redirect_to user_path, notice: 'You have updated data'
      else
        redirect_to user_path, notice: current_user.errors.full_messages.to_s
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end
end
