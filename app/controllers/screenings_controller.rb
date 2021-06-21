# frozen_string_literal: true

class ScreeningsController < ApplicationController

  api :GET, "/movies/:id/screenings", "Shows all screenings for movie with given id"
  def index
    @screenings = Screenings::Repository.new.fetch(movie_id: params[:movie_id])
    render json: Screenings::Representer.new(@screenings).basic
  end

  api :GET, '/movies/:id/screenings/:id', 'Shows a deailed information about screening'
  def show
    screening = Screenings::Repository.new.find_by(params[:id])
    render json: Screenings::Representer.new([screening]).extended
  end

  def create
    authorize Screening
    screening = Screenings::UseCases::Create.new.call(params: screening_params)

    if screening.valid?
      render json: screening, status: :created
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize Screening
    screening = Screenings::UseCases::Update.new.call(id: params[:id], params: screening_params)
    if screening.valid?
      render json: screening
    else
      render json: screening.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize Screening
    Screenings::UseCases::Delete.new.call(id: params[:id])
    render json: { status: 'deleted' }
  end

  private

  def screening_params
    params.require(:screening).permit(:date, :cinema_hall_id, :movie_id)
  end
end
