class TicketsController < ApplicationController
  def index
    @tickets = Tickets::UseCases::FetchWithColumns.new.call(params[:reservation_id])
    render json: Tickets::Representer.new(@tickets).basic
  end

  def show
    ticket = Tickets::Repository.new.find_by(params[:id])
    render json: Tickets::Representer.new([ticket]).extended
  end

  def create
    if Tickets::UseCases::SeatAvailable.new(ticket_params[:reservation_id],ticket_params[:seat]).call
      ticket = Tickets::UseCases::Create.new.call(params: ticket_params)
      
      if ticket.valid?
          update_screening_seats
          render json: ticket, status: :created
      else
          render json: ticket.errors, status: :unprocessable_entity
      end
    else
      render json: {status: "seat taken"}
    end
  end

  def update
    ticket = Tickets::UseCases::Update.new.call(id: params[:id], params: ticket_params)
      if ticket.valid?
          render json: ticket
      else
          render json: ticket.errors, status: :unprocessable_entity
      end
  end

  def destroy
    Tickets::UseCases::Delete.new.call(id: params[:id])
    render json: {status: "deleted"}
  end

  

  private
  
  def ticket_params
    params.require(:ticket).permit(:reservation_id, :type, :price, :seat)
  end

  def update_screening_seats
    reservation = Reservations::Repository.new.find_by(ticket_params[:reservation_id])
    screening_id = reservation.screening_id
    available_seats = Screenings::UseCases::FindAvailableSeats.new(screening_id).call
    Screenings::UseCases::Update.new.call(id: screening_id, params: {available_seats: available_seats })
  end

  
end
