# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::Update do
  let(:hall) { create :cinema_hall, capacity: 50, name: 'Some Name' }
  let(:params) do
    {
      capacity: 100,
      name: name
    }
  end
  let(:name) { 'Updated Name' }
  let(:instance) { described_class.new }

  subject { instance.call(params: params, id: hall.id) }

  describe '.call' do
    it 'updates Cienma Hall' do
      expect { subject }
        .to change { hall.reload.name }.from('Some Name').to('Updated Name')
                                       .and change { hall.reload.capacity }.from(50).to(100)
    end

    it 'retuns true' do
      expect(subject).to eq(hall)
    end

    it 'returns hall object without errors' do
      expect(subject.errors).to be_empty
    end

    context 'when params invalid' do
      let(:name) { nil }

      it "doesn't update hall" do
        expect { subject }.not_to change { hall.reload.name }
      end

      it 'returns hall object with errors array not empty' do
        expect(subject.errors).not_to be_empty
      end

      it 'returns hall object with proper errors' do
        expect(subject.errors).to match_array(["Name can't be blank"])
      end
    end
  end
end
