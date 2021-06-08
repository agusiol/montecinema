class CinemaHallsController < ApplicationController
  def index
    @cinema_halls = CinemaHalls::UseCases::FindAll.new.call
    render json: CinemaHalls::Representer.new(@cinema_halls).basic
  end

  def show
    cinema_hall = CinemaHalls::Repository.new.find_by(params[:id])
    render json: CinemaHalls::Representer.new([cinema_hall]).extended
  end

  def create
    cinema_hall = CinemaHalls::UseCases::Create.new.call(params: cinema_hall_params)
    if cinema_hall.valid?
      render json: cinema_hall, status: :created
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def update
    cinema_hall = CinemaHalls::UseCases::Update.new.call(id: params[:id], params: cinema_hall_params)
    if cinema_hall.valid?
      render json: cinema_hall
    else
      render json: cinema_hall.errors, status: :unprocessable_entity
    end
  end

  def destroy
    CinemaHalls::UseCases::Delete.new.call(id: params[:id])
    render json: { status: 'deleted' }
  end

  private

  def cinema_hall_params
    params.require(:cinema_hall).permit(:name, :capacity)
  end
end
