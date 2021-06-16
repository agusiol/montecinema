# frozen_string_literal: true

module Reservations
  module UseCases
    class CreateOnline < Reservations::UseCases::CreateReservationWithTickets
      def call(params:)
        super
        send_email
        @reservation
      end

      def send_email
        user = Users::Repository.new.find_by(@reservation.user_id)
        screening = Screenings::Repository.new.find_by(@reservation.screening_id)
        movie = Movies::Repository.new.find_by(screening.movie_id)

        ReservationMailer.confirmation_email(
          reservation: @reservation,
          email: user.email,
          date: screening.date,
          movie: movie.title
        ).deliver_later
      end
    end
  end
end
