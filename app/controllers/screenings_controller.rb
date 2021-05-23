class ScreeningsController < ApplicationController
    before_action :set_screening, only: [:show, :update, :destroy]
    def index
        render json: @screenings
    end

    def show
        render json: @screening
    end

    def create
        @cinema_hall = CinemaHall.find(params[:cinema_hall_id])
        @screening = @cinema_hall.screening.create(screening_params)
        #array with available seats. the idea is to mark them later with rows ex. A1, F5 etc.
        @screening.seats = (1..@cinema_hall.capacity).to_a  
        if @screening.save
            render json: @screening, status: :created
        else
            render json: @screening.errors, status: :unprocessable_entity
        end

    end

    def update
        if @screening.update(screening_params)
            render json: @screening
        else
            render json: @screening.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @screening.destroy
    end

    private
    def set_screening
        @screening = Screening.find(params[:id])
    end
        
    def screening_params
        params.require(:screening).permit(:date)
    end

end