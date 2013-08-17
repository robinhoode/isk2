class SearchController < ApplicationController
  def index
    @titles = Title.order("id DESC").paginate(page: params[:page])
  end

  def query
    @titles = Title.search(params[:term]).paginate(page: params[:page])
    render action: "results"
  end

  def advanced
    @titles = Title.advanced_search(params)
    render action: "results"
  end
end
