# frozen_string_literal: true

class MoviesController < ApplicationController

  api :GET, "/movies", "Shows all movies"
  def index
    @movies = Movies::Repository.new.find_all
    render json: Movies::Representer.new(@movies).basic
  end

  api :GET, "/movies/:id", "Shows a detiled information about movie and its next 5 screenings"
  def show
    movie = Movies::Repository.new.find_by(params[:id])
    render json: Movies::Representer.new([movie]).extended
  end

  def create
    authorize Movie
    movie = Movies::UseCases::Create.new.call(params: movie_params)
    if movie.valid?
      render json: movie, status: :created
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize Movie
    movie = Movies::UseCases::Update.new.call(id: params[:id], params: movie_params)
    if movie.valid?
      render json: movie
    else
      render json: movie.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Movie
    Movies::UseCases::Delete.new.call(id: params[:id])
    render json: { status: 'deleted' }
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :genre, :age_allowed, :duration)
  end
end
