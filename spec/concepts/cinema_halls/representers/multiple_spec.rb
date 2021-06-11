# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::Representers::Multiple do
  describe '.call' do
    let(:hall1) { create :cinema_hall }
    let(:hall2) { create :cinema_hall }
    let(:halls) { [hall1, hall2] }
    let(:instance) { CinemaHalls::Representers::Multiple.new(halls) }

    it 'returns proper hash with cinema halls' do
      expect(instance.call).to match_array(
        [
          {
            id: hall1.id,
            name: hall1.name,
            capacity: hall1.capacity
          },
          {
            id: hall2.id,
            name: hall2.name,
            capacity: hall2.capacity
          }
        ]
      )
    end
  end
end
