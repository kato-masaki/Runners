class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :unsubscribe, :destroy]

  def show
    @user = User.find(params[:id])
    @diaries = @user.diaries.page(params[:page]).per(9).reverse_order
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "更新しました。"
    else
      render 'edit'
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, notice: "退会処理を受け付けました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :residence, :occupation)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.me? current_user.id
      redirect_to user_path(current_user)
    end
  end
end
