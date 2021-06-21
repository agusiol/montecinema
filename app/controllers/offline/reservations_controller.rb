# frozen_string_literal: true

module Offline
  class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :staff_authorize!

    resource_description do
      short 'Offline Reservations/ Only for staff members'
      formats ['json']
    end

    def_param_group :reservation do
      param :reservation, Hash do
        param :screening_id , Integer, required: true
        param :ticket_desk_id , Integer, required: true
        param :status , String, 'confirmed or paid', required: true
        param :tickets, Array, ' Array of tickets with {price ticket_type seat}', required: true do
          param :price, Float, required: true
          param :seat, String , 'ex. "1A" , 2E', required: true
          param :ticket_type, String, required: true
        end
      end
    end

    api :GET, "/offline/reservations", "Display all reservations "

    def index
      @reservations = Reservations::Repository.new.find_all
      render json: Reservations::Representer.new(@reservations).basic
    end

    api :GET, "/offline/reservations/:id", "Detailed info about reservation"
    def show
      reservation = Reservations::Repository.new.find_by(params[:id])
      render json: Reservations::Representer.new([reservation]).extended
    end

    api :POST, "/offline/reservations", "Creates a reservation with tickets"
    param_group :reservation
    def create
      user = Users::Repository.new.offline_user
      @reservation = Reservations::UseCases::CreateOffline.new.call(params: reservation_params.merge(user_id: user.id))
      render json: Reservations::Representer.new([@reservation]).extended, status: :created
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render json: { error: e.message }.to_json
    end

    api :PUT, "/offline/reservations/:id", "Changes reservation status from confirmed to paid "
    def update
      reservation = Reservations::UseCases::Pay.new.call(id: params[:id])
      if reservation.valid?
        render json: reservation
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
    end

    api :DELETE, "/offline/reservations/:id", "Deletes reservation "
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
        tickets: %i[price ticket_type seat]
      )
    end
  end
end
