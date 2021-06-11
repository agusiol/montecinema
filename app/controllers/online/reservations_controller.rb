# frozen_string_literal: true

module Online
  class ReservationsController < ApplicationController
    def index
      @reservations = Reservations::UseCases::FetchWithColumns.new.call(params[:screening_id])
      render json: Reservations::Representer.new(@reservations).basic
    end

    def show
      reservation = Reservations::Repository.new.find_by(params[:id])
      render json: Reservations::Representer.new([reservation]).extended
    end

    def create
      reservation = Reservations::UseCases::CreateOnline.new.call(params: reservation_params.merge(status: 'confirmed'))
      render json: Reservations::Representer.new([reservation]).extended, status: :created
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render json: { error: e.message }.to_json
    end

    private

    def reservation_params
      params.require(:reservation).permit(
        :status,
        :screening_id,
        :client_id,
        tickets: %i[price ticket_type seat screening_id]
      )
    end
  end
end
