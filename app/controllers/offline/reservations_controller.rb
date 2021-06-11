# frozen_string_literal: true

module Offline
  class ReservationsController < ApplicationController
    def index
      @reservations = Reservations::Repository.new.find_all
      render json: Reservations::Representer.new(@reservations).basic
    end

    def show
      reservation = Reservations::Repository.new.find_by(params[:id])
      render json: Reservations::Representer.new([reservation]).extended
    end

    def create
      client = Clients::Repository.new.offline_client
      reservation = Reservations::UseCases::CreateOffline.new.call(params: reservation_params.merge(client_id: client.id))

      render json: Reservations::Representer.new([reservation]).extended, status: :created
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render json: { error: e.message }.to_json
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
        tickets: %i[price ticket_type seat screening_id]
      )
    end
  end
end
