# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::GenerateSeats do
  let(:capacity) { 50 }
  let(:instance) { described_class.new(capacity) }

  subject { instance.call }

  describe '.call' do
    it 'returns array with length equal to capacity' do
      expect(subject.length).to eq(capacity)
    end

    it 'returns array with seats in correct format' do
      expect(subject[0]).to eq('1A')
    end
  end
end
