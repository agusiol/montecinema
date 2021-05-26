class ReservationsController < ApplicationController
    before_action :set_reservation, only: [:show, :update, :destroy]
    def index
        @reservations = Reservation.all
        render json: @reservations
    end

    def show
        render json: @reservation
    end

    def create
        @screening = Screening.find(params[:screening_id])
        #status should be somehow limited to confirmed, paied, cancelled
        @reservation = @screening.reservations.create(reservation_params)
        @reservation.ticket_desk_id = params[:ticket_desk_id]
        @reservation.client_id = params[:client_id]
        #time whe the reservation should be cancceled if not paid.
        #maybe this paraeter is not necessary? for further consideration
        @reservation.valid_to = (@screening.date.to_time - 0.5.hours).to_datetime
        if @reservation.save
            render json: @reservation, status: :created
        else
            render json: @reservation.errors, status: :unprocessable_entity
        end

    end

    def update
        if @reservation.update(reservation_params)
            render json: @reservation
        else
            render json: @reservation.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @reservation.destroy
    end

    private
    def set_reservation
        @reservation = Reservation.find(params[:id])
    end
        
    def reservation_params
        params.require(:reservation).permit(:status)
    end

end