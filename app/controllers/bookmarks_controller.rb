class BookmarksController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    bookmark = current_user.bookmarks.new(diary_id: @diary.id)
    bookmark.save
  end

  def destroy
    @diary = Diary.find(params[:diary_id])
    bookmark = current_user.bookmarks.find_by_diary_id(@diary.id)
    bookmark.destroy
  end

  def index
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:diary_id)
    @bookmark_list = Diary.find(bookmarks)
  end
end
