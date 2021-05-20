class CinemahallsController < ApplicationController
    before_action :set_cinemahall, only: [:show, :update, :destroy]
    def index
        @cinemahalls = CinemaHall.all 
        render json: @cinemahalls
    end

    def show
        render json: @cinemahall
    end

    def create
        @cinemahall = CinemaHall.new(cinemahall_params)
        if @cinemahall.save
            render json: @cinemahall, status: :created
        else
            render json: @cinemahall.errors, status: :unprocessable_entity
        end

    end

    def update
        if @cinemahall.update(cinemahall_params)
            render json: @cinemahall
        else
            render json: @cinemahall.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @cinemahall.destroy
    end

    private
    def set_cinemahall
        @cinemahall = CinemaHall.find(params[:id])
    end
        
    def cinemahall_params
        params.require(:cinemahall).permit(:name, :capacity)
    end


end