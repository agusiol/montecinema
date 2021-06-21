# frozen_string_literal: true

module Online
  class ReservationsController < ApplicationController
    before_action :authenticate_user!

    resource_description do
      short 'ONLINE Reservations'
      formats ['json']
    end

    def_param_group :reservation do
      param :reservation, Hash do
        param :screening_id, Integer, required: true
        param :tickets, Array, ' Array of tickets with {price ticket_type seat}', required: true do
          param :price, Float, required: true
          param :seat, String, 'ex. "1A" , 2E', required: true
          param :ticket_type, String, required: true
        end
      end
    end

    api :GET, '/online/reservations', "Display logged in User's reservations "

    def index
      authorize Reservation
      @reservations = policy_scope(Reservation)
      render json: Reservations::Representer.new(@reservations).basic
    end

    api :GET, '/online/reservations/:id', 'Detailed info about reservation'
    def show
      @reservation = Reservations::Repository.new.find_by(params[:id])
      authorize @reservation
      render json: Reservations::Representer.new([@reservation]).extended
    end

    api :POST, '/online/reservations', 'Creates a reservation with tickets'
    param_group :reservation
    # example   <<-EOS
    # {
    #   "reservation":  {
    #       "screening_id": 1,
    #       "tickets": [
    #           { "price": 15, "ticket_type": "normal", "seat": "6J" },
    #           { "price": 15, "ticket_type": "normal", "seat": "6F" },
    #           { "price": 15, "ticket_type": "normal", "seat": "6G" },
    #           { "price": 7.5, "ticket_type": "child", "seat": "6H" },
    #           { "price": 7.5, "ticket_type": "child", "seat": "6I" }
    #       ]
    #   }
    # EOS

    def create
      reservation = Reservations::UseCases::CreateOnline.new.call(params: reservation_params.merge(status: 'confirmed',
                                                                                                   user_id: current_user.id))
      render json: Reservations::Representer.new([reservation]).extended, status: :created
    rescue Tickets::UseCases::Create::SeatsNotAvailableError => e
      render json: { error: e.message }.to_json
    end

    api :DELETE, '/online/reservations/:id', 'Deletes reservation if it belongs to logged in User '
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
end
