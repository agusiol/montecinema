# frozen_string_literal: true


  class Online::ReservationsController < ApplicationController
    before_action :authenticate_user!
    def index
      authorize Reservation
      @reservations = policy_scope(Reservation)
      render json: Reservations::Representer.new(@reservations).basic
    end

    def show
      @reservation = Reservations::Repository.new.find_by(params[:id])
      authorize @reservation
      render json: Reservations::Representer.new([@reservation]).extended
    end

    def create
      reservation = Reservations::UseCases::CreateOnline.new.call(params: reservation_params.merge(status: 'confirmed', user_id: current_user.id))
      render json: Reservations::Representer.new([reservation]).extended, status: :created
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render json: { error: e.message }.to_json
    end

    def destroy
      @reservation = Reservations::Repository.new.find_by(params[:id])
      authorize @reservation
      Reservations::UseCases::Delete.new.call(id: params[:id])
      render json: { status: 'deleted' }
    end

    private

    def reservation_params
      params.require(:reservation).permit(
        :screening_id,
        tickets: %i[price ticket_type seat screening_id]
      )
    end
  end
