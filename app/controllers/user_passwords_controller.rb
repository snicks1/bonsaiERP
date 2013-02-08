# encoding: utf-8
class UserPasswordsController < ApplicationController
  def edit
    render get_template
  end

  def update
    if verify_valid_old_password? && current_user.update_attributes(password_params)
      redirect_to current_user, notice: "Su contraseña ha sido actualizada."
    else
      render get_template
    end
  end

private
  def password_params
    params.require(:user).permit(:old_password, :password, :password_confirmation)
  end

  def get_template
    if current_user.change_default_password?
      'edit_default'
    else
      'edit'
    end
  end

  def verify_valid_old_password?
    return true if current_user.change_default_password?

    current_user.valid_password? params[:user][:old_password]
  end
end