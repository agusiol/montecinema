require 'rails_helper'

RSpec.describe CinemaHalls::Representers::Single do
  describe '.call' do
    let(:seats) { CinemaHalls::UseCases::GenerateSeats.new(50).call }
    let(:hall) { create :cinema_hall, seats: seats }
    let(:instance) { CinemaHalls::Representers::Single.new(hall) }

    it 'returns proper hash' do
      expect(instance.call).to eq(
        {
          id: hall.id,
          name: hall.name,
          capacity: hall.capacity,
          seats: hall.seats
        }
      )
    end
  end
end
