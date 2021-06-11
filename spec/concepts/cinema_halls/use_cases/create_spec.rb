# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::Create do
  let(:capacity) { 50 }
  let(:name) { 'Some name' }
  let(:seats) { CinemaHalls::UseCases::GenerateSeats.new(capacity).call }
  let(:instance) { described_class.new }
  let(:params) do
    {
      capacity: capacity,
      name: name,
      seats: seats
    }
  end

  subject { instance.call(params: params) }

  describe '.call' do
    it 'creates new CinemaHall' do
      expect { subject }.to change { CinemaHall.count }.by(1)
    end

    it 'returns CinemaHall object' do
      expect(subject).to be_a_kind_of(CinemaHall)
    end

    it 'returns CinemaHall object with proper attributes' do
      expect(subject).to have_attributes(params)
    end

    it 'returns object without errors' do
      expect(subject.errors).to match_array([])
    end

    context 'when params invalid' do
      let(:name) { nil }

      it 'returns object with errors' do
        expect(subject.errors).to match_array(["Name can't be blank"])
      end
    end
  end
end
