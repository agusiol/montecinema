class ReservationMailer < ActionMailer::Preview
  def confirmation_email
    ReservationMailer.with(user: Reservation.first).welcome_email
  end
end
