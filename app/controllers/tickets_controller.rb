class TicketsController < ApplicationController
    def index
        render json: @tickets
    end

    def show
        set_ticket
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
        set_ticket
        if @ticket.update(ticket_params)
            render json: @ticket
        else
            render json: @ticket.errors, status: :unprocessable_entity
        end
    end

    def destroy
        set_ticket
        @ticket.destroy
        render json: {status: "deleted"}
    end

    private
    def set_ticket
        @ticket = Ticket.find(params[:id])
    end
        
    def ticket_params
        params.require(:ticket).permit(:seat, :type, :price)
    end

end