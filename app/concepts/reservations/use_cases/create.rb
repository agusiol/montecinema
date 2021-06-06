module Reservations
  module UseCases
    class Create
      attr_reader :repository

      def initialize(repository: Reservations::Repository.new)
        @repository = repository
      end

      def call(params:)
       
          Reservation.transaction do

            puts params
            reservation_params = params.except(:tickets)
            puts reservation_params
            @reservation = repository.create(reservation_params)
            puts @reservation
            Tickets::UseCases::Create.new(reservation: @reservation, tickets: params[:tickets]).call
          end
          send_email
        
      end

      def send_email
        client = Clients::Repository.new.find_by(@reservation.client_id)
        screening = Screenings::Repository.new.find_by(@reservation.screening_id)
        movie = Movies::Repository.new.find_by(screening.movie_id)        

        ReservationMailer.confirmation_email(
          reservation: @reservation, 
          email: client.email, 
          date: screening.date,
          movie: movie.title
        ).deliver_now
      end


    end
  end
end