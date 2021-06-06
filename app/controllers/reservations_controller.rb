class ReservationsController < ApplicationController
  def index
    @reservations = Reservations::UseCases::FetchWithColumns.new.call(params[:screening_id], params[:client_id])
    render json: Reservations::Representer.new(@reservations).basic
  end

  def show
    reservation = Reservations::Repository.new.find_by(params[:id])
    render json: Reservations::Representer.new([reservation]).extended
  end

  def create
    reservation = Reservations::UseCases::Create.new.call(params: reservation_params)
        render json: reservation, status: :created
      rescue Tickets::UseCases::Create::SeatsNotAvailableError => error
        render json: { error: error.message }.to_json
    
    
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
    render json: {status: "deleted"}
  end

  
  private
  
  def reservation_params
    params.require(:reservation).permit(
      :status, 
      :screening_id, 
      :ticket_desk_id, 
      :client_id,
      tickets: %i[price type seat screening_id]
    )
  end
end
