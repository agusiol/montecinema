class TicketsController < ApplicationController
    before_action :set_ticket, only: [:show, :update, :destroy]
    def index
        render json: @tickets
    end

    def show
        render json: @ticket
    end

    def create
        @reservation = Reservation.find(params[:reservation_id])
        @ticket = @reservation.tickets.create(ticket_params)
       #ticket seat should be somehow validetated if it is in screening available seats
       #after creation seat should be removed from screening's available seats? 
        if @ticket.save
            render json: @ticket, status: :created
        else
            render json: @ticket.errors, status: :unprocessable_entity
        end

    end

    def update
        if @ticket.update(ticket_params)
            render json: @ticket
        else
            render json: @ticket.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @ticket.destroy
    end

    private
    def set_ticket
        @ticket = Ticket.find(params[:id])
    end
        
    def ticket_params
        params.require(:ticket).permit(:seat, :type, :price)
    end

end