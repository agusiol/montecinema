# frozen_string_literal: true

class CancelReservationsJob < ApplicationJob
  queue_as :default

  def perform(screening_id)
    # find unpaid reservations
    reservations = Reservations::Repository.new.unpaid(screening_id)

    reservations.map do |reservation|
      # find the user for given reservation and send email if it's real_user(online reservation)
      user = Users::Repository.new.find_by(reservation.user_id)
      if user.real_user
        ReservationMailer.with(reservation: reservation, email: user.email).cancellation_email.deliver_later
      end

      Reservations::UseCases::Delete.new.call(id: reservation.id)
    end
  end
end
