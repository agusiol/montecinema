class MoviesController < ApplicationController
    def index
        @movies = Movie.all
        
        render json: @movies
    end

    def show
        set_movie
        render json: @movie
    end

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            render json: @movie, status: :created
        else
            render json: @movie.errors, status: :unprocessable_entity
        end

    end

    def update
        set_movie
        if @movie.update(movie_params)
            render json: @movie
        else
            render json: @movie.errors, status: :unprocessable_entity
        end
    end

    def destroy
        set_movie
        @movie.destroy
        render json: {status: "deleted"}
    end

    private
    def set_movie
        @movie = Movie.find(params[:id])
    end
        
    def movie_params
        params.require(:movie).permit(:title, :genre, :age_allowed)
    end


end