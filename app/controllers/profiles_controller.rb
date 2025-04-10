class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'Perfil actualizado con éxito.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :photo)
  end
end
