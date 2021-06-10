require 'rails_helper'

RSpec.describe Reservations::UseCases::CreateReservationWithTickets do
  let(:hall) { create :cinema_hall, seats: CinemaHalls::UseCases::GenerateSeats.new(100).call }
  let(:screening) { create :screening, cinema_hall_id: hall.id }
  let(:ticket_desk) { create :ticket_desk }
  let(:client) { create :client }
  let(:instance) { described_class.new }
  let(:params) do
    {
      status: 'confirmed',
      screening_id: screening.id,
      ticket_desk_id: ticket_desk.id,
      client_id: client.id,
      tickets: tickets
    }
  end

  let(:tickets) do
    [
      { "price": 15, "ticket_type": 'normal', "seat": '3A' },
      { "price": 15, "ticket_type": 'normal', "seat": '3B' },
      { "price": 15, "ticket_type": 'normal', "seat": '3C' },
      { "price": 15, "ticket_type": 'normal', "seat": '3D' },
      { "price": 15, "ticket_type": 'normal', "seat": '3E' }
    ]
  end

  subject { instance.call(params: params) }

  context 'all seats are available' do
    it 'creates reservation' do
      expect { subject }.to change { Reservation.count }.by(1)
    end

    it 'creates all given tickets' do
      expect { subject }.to change { Ticket.count }.by(5)
    end
  end

  context 'one seat in the middle is not available' do
    let!(:reservation) { create :reservation, screening_id: screening.id }
    let!(:ticket) { create :ticket, seat: '3C', reservation_id: reservation.id }
    #not working
    it 'raisees SeatNotAvailable error' do
      expect {subject}.to raise_error(Tickets::UseCases::Create::SeatsNotAvailableError)
    end
  end

  context 'all seats are not available' do
  end
end
