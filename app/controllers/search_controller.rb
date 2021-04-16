class SearchController < ApplicationController
  def search
    @model = params[:model]
		@content = params[:content]
		if @model == 'user'
		  @data = User.search_for(@content)
		else
		  @data = Diary.search_for(@content)
		end
  end
end
