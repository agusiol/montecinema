# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
  def confirmation_email
    ReservationMailer.confirmation_email(reservation: Reservation.first, 
      email: "example@email.com", 
      date: "2021-07-06 13:30:00", 
      movie: "Example")
  end
end
