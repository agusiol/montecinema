# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Screenings::UseCases::FindAvailableSeats do
  let!(:screening) { create :screening }
  let!(:instance) { described_class.new(screening.id) }

  subject { instance.call }

  describe '.call' do
    it 'returns available seats array' do
      expect(subject).to be_a_kind_of(Array)
    end

    context 'all seats available/ no reservation made' do
      let!(:hall) { create :cinema_hall }
      it 'returns eql to cinema_hall.seats' do
        expect(subject).to eq(hall.seats)
      end
    end

    context 'some seats are reserved' do
      let!(:hall) { create :cinema_hall }
      let!(:reservation) { create :reservation, screening_id: screening.id }
      let!(:ticket1) { create :ticket, reservation_id: reservation.id, seat: '1A' }
      let!(:ticket2) { create :ticket, reservation_id: reservation.id, seat: '2A' }
      let!(:ticket3) { create :ticket, reservation_id: reservation.id, seat: '3A' }

      it 'returns array without seats 1A, 1B, 1C' do
        expect(subject).to eq(hall.seats - [ticket1.seat, ticket2.seat, ticket3.seat])
      end
    end

    # context 'all seats are reserved' do
    #   it 'returns empty array' do
    #     expect(subject).to eq([])
    #   end
    # end
  end
end
