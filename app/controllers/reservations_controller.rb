class ReservationsController < ApplicationController
  def index
    @reservations = Reservations::UseCases::FetchWithColumns.new.call(params[:cinema_hall_id],params[:movie_id])
    render json: Reservations::Representer.new(@reservations).basic
  end

  def show
    reservation = Reservations::Repository.new.find_by(params[:id])
    render json: Reservations::Representer.new([reservation]).extended
  end

  def create
    reservation = Reservations::UseCases::Create.new.call(params: reservation_params)
    
    if reservation.valid?
        render json: reservation, status: :created
      else
        render json: reservation.errors, status: :unprocessable_entity
      end
  end

  def update
    reservation = Reservations::UseCases::Update.new.call(id: params[:id], params: reservation_params)
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

  
<<<<<<< HEAD

  private
  
  def reservation_params
    params.require(:reservation).permit(:status, :screening_id, :ticket_desk_id)
  end
end

#     def index
#         @reservations = Reservation.all
#         render json: @reservations
#     end

#     def show
#         set_reservation
#         render json: @reservation
#     end

#     def create
#         @reservation = reservation.find(params[:reservation_id])
#         @reservation = @reservation.reservations.create(reservation_params)
#         @reservation.ticket_desk_id = params[:ticket_desk_id]
#         @reservation.client_id = params[:client_id]
#         #time whe the reservation should be cancceled if not paid.
#         #maybe this paraeter is not necessary? for further consideration
#         @reservation.valid_to = (@reservation.date.to_time - 0.5.hours).to_datetime
#         if @reservation.save
#             render json: @reservation, status: :created
#         else
#             render json: @reservation.errors, status: :unprocessable_entity
#         end

#     end

#     def update
#       set_reservation
#         if @reservation.update(reservation_params)
#             render json: @reservation
#         else
#             render json: @reservation.errors, status: :unprocessable_entity
#         end
#     end

#     def destroy
#         set_reservation
#         @reservation.destroy
#         render json: {status: "deleted"}
#     end

#     private
#     def set_reservation
#         @reservation = Reservation.find(params[:id])
#     end
        
#     def reservation_params
#         params.require(:reservation).permit(:status)
#     end

# end
=======

  private
  
  def reservation_params
    params.require(:reservation).permit(:status, :screening_id, :ticket_desk_id)
  end
end
>>>>>>> f6136dcd4ca59c4afe052944e81feffbc7e4245b
