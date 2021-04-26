class RecordsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @record = Record.new
    @records = Record.where(user_id: current_user.id)
  end

  def create
    @record = Record.new(record_params)
    @record.user_id = current_user.id
    if @record.save
      redirect_to records_path, notice: "記録しました。"
    else
      @records = Record.where(user_id: current_user.id)
      render 'index'
    end
  end

  def edit
    @record = Record.find(params[:id])
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      redirect_to records_path, notice: "更新しました。"
    else
      render 'edit'
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    redirect_to records_path, alert: "削除しました。"
  end

  private

  def record_params
    params.require(:record).permit(:start_time, :distance, :hour, :minute, :second, :pace_minute, :pace_second)
  end

  def ensure_correct_user
    @record = Record.find(params[:id])
    unless @record.user == current_user
      redirect_to user_path(current_user)
    end
  end
end
