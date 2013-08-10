class SearchController < ApplicationController
  def index
    @titles = Title.order("id DESC").limit(20)
  end

  def query
    @titles = Title.search(params[:term])
    render action: "results"
  end  

  def advanced
    @titles = Title.advanced_search(params)
    render action: "results"
  end
end
