# frozen_string_literal: true

class ReservationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reservations = Reservations::Repository.new.fetch(screening_id: params[:screening_id])
    render json: Reservations::Representer.new(@reservations).basic
  end

  def show
    reservation = Reservations::Repository.new.find_by(params[:id])
    render json: Reservations::Representer.new([reservation]).extended
  end

  def update
    reservation = Reservations::UseCases::Pay.new.call(id: params[:id])
    if reservation.valid?
      render json: reservation
    else
      render json: reservation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Reservations::UseCases::Delete.new.call(id: params[:id])
    render json: { status: 'deleted' }
  end

  private

  def reservation_params
    params.require(:reservation).permit(
      :status,
      :screening_id,
      :ticket_desk_id,
      :client_id,
      tickets: %i[price ticket_type seat screening_id]
    )
  end
end
