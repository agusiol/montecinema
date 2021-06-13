# frozen_string_literal: true

class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform(screening_id)
    # find unpaid reservations
    reservations = Reservations::Repository.new.unpaid(screening_id)

    reservations.map do |reservation|
      # find the client for given reservation and send email if it's real_user(online reservation)
      client = Clients::Repository.new.find_by(reservation.client_id)
      if client.real_user
        ReservationMailer.with(reservation: reservation, email: client.email).cancellation_email.deliver_later
      end
    
      Reservations::UseCases::Delete.new.call(id: reservation.id)
    end
  end
end
