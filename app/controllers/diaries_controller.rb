class DiariesController < ApplicationController

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_id = current_user.id
    @diary.save
    redirect_to diaries_path
  end

  def index
    @diaries = Diary.page(params[:page]).per(9).reverse_order
  end

  def show
    @diary = Diary.find(params[:id])
    @diary_comment = DiaryComment.new
  end

  def edit
  end

  def update
  end

  def destroy
    @diary = Diary.find(params[:id])
    @diary.destroy
    redirect_to diaries_path
  end

  private

  def diary_params
    params.require(:diary).permit(:image, :caption, :distance, :hour, :minute, :second, :pace_minute, :pace_second)
  end

  def self.search_for(content)
    Diary.where('name LIKE ?', '%' + content + '%')
  end

end
