require 'rails_helper'

RSpec.describe CinemaHalls::UseCases::Delete do
  let!(:hall) { create :cinema_hall }
  let(:instance) { described_class.new }

  subject { instance.call(id: hall.id) }

  describe '.call' do
    it 'deletes cinema hall' do
      expect { subject }.to change { CinemaHall.count }.by(-1)
    end
  end
end
