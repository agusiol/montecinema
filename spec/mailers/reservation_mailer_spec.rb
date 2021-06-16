# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReservationMailer, type: :mailer do
  describe 'confirmation_email' do
    let(:movie) { create(:movie) }
    let(:hall) { create(:cinema_hall) }
    let(:user) { create(:user) }
    let(:ticket_desk) { create(:ticket_desk) }
    let(:screening) { create(:screening, cinema_hall_id: hall.id, movie_id: movie.id) }

    let(:reservation) do
      create(:reservation, screening_id: screening.id, user_id: user.id, ticket_desk_id: ticket_desk.id)
    end
    let(:mail) do
      ReservationMailer.confirmation_email(
        reservation: reservation,
        movie: movie.title,
        date: screening.date,
        email: user.email
      )
    end

    it 'renders the header' do
      expect(mail.subject).to eq('Reservation done')
      expect(mail.to).to eq(['example@email.com'])
      expect(mail.from).to eq(['notifications@example.com'])
    end

    it 'renders the body' do
      expect(mail.text_part.body.to_s).to include(
        "Your reservation: #{reservation.id} for #{movie.title} has been succesfull."
      )
      expect(mail.html_part.body.to_s).to include(
        "Your reservation: #{reservation.id} for #{movie.title} has been succesfull."
      )
    end

    it 'sends the email' do
      assert_emails 1 do
        mail.deliver_now
      end
      expect(ActionMailer::Base.deliveries.first.subject).to eq('Reservation done')
    end
  end
end
