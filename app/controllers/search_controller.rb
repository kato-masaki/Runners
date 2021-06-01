class SearchController < ApplicationController
  def search
    @model = params[:model]
    @content = params[:content]
    @data = if @model == 'user'
              User.search_for(@content)
            else
              Diary.search_for(@content).page(params[:page]).per(9).reverse_order
            end
  end
end
