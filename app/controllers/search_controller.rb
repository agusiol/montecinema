class SearchController < ApplicationController
  def index
    @movies = Movies::Repository.new.search_by_title(params[:text])
    render json: Movies::Representer.new(@movies).basic
  end
end