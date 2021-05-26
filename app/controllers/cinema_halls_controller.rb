class CinemaHallsController < ApplicationController
    
    def index
        @cinema_halls = CinemaHall.all.map do |cinema_hall|
            {
                name: cinema_hall.name,
                capacity: cinema_hall.capacity
            }
        end
        
        render json: @cinema_halls
    end

    def show
        @cinema_hall = {
            id: @cinema_hall.id,
            name: @cinema_hall.name,
            cpacity: @cinema_hall.capacity
        }
        render json: @cinema_hall
    end

    def create
      @cinema_hall = CinemaHall.new(cinema_hall_params)
        if @cinema_hall.save
            render json: @cinema_hall, status: :created
        else
            render json: @cinema_hall.errors, status: :unprocessable_entity
        end

    end

    def update
      set_cinema_hall
        if @cinema_hall.update(cinema_hall_params)
            render json: @cinema_hall
        else
            render json: @cinema_hall.errors, status: :unprocessable_entity
        end
    end

    def destroy
      set_cinema_hall
        @cinema_hall.destroy
        render json: {status: "deleted"}
    end

    private
    def set_cinema_hall
        @cinema_hall = CinemaHall.find(params[:id])
    end
        
    def cinema_hall_params
        params.require(:cinema_hall).permit(:name, :capacity)
    end


end