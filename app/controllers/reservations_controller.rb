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
    ticket_desk = TicketDesks::Repository.new.find_by(params[:ticket_desk_id])

    reservation = if ticket_desk.type == 'online'
                    Reservations::UseCases::CreateOnline.new.call(params: reservation_params.merge(status: 'confirmed'))
                  else
                    Reservations::UseCases::CreateOffline.new.call(params: reservation_params.merge(client_id: 1))
                  end

    render json: reservation, status: :created
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
      :client_id,
      tickets: %i[price type seat screening_id]
    )
  end
end
