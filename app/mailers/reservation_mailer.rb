class ReservationMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def confirmation_email
    @reservation = params[:reservation]
    email = params[:email]
    text = "We are confiming your reservation"
    mail(
      to: email,
      subject: 'Reservation done') do |format|
        format.text { render html: text }
      end 
  end

  def cancellation_email
    @reservation = params[:reservation]
    email = params[:email]
    text = "You did't pay for your tickets 30 minuts before screening and your reservation has been cancelled"
    mail(
      to: email,
      subject: 'Reservation done') do |format|
        format.text { render html: text }
      end 
  
  end
end
