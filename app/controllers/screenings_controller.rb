class ScreeningsController < ApplicationController
    def index
        @screenings = Screening.all
        render json: @screenings
    end

    def show
        set_screening
        render json: @screening
    end

    def create
        @cinema_hall = CinemaHall.find(params[:cinema_hall_id])
        @movie = Movie.find(params[:movie_id])
        @screening = @cinema_hall.screenings.create(screening_params)
        @screening.movie_id = @movie.id
        #array with available seats. should be reconsider later if this is a good approach
        #the idea is to mark them later with rows ex. A1, F5 etc.
        @screening.seats = (1..@cinema_hall.capacity).to_a  
        if @screening.save
            render json: @screening, status: :created
        else
            render json: @screening.errors, status: :unprocessable_entity
        end

    end

    def update
        set_screening
        if @screening.update(screening_params)
            render json: @screening
        else
            render json: @screening.errors, status: :unprocessable_entity
        end
    end

    def destroy
        set_screening
        @screening.destroy
        render json: {status: "deleted"}
    end

    private
    def set_screening
        @screening = Screening.find(params[:id])
    end
        
    def screening_params
        params.require(:screening).permit(:date)
    end

end