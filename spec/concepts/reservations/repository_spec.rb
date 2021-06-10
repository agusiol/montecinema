require 'rails_helper'

RSpec.describe Reservations::Repository do
  let(:instance) { described_class.new }

  describe '.unpaid' do
    let!(:screening) { create :screening }
    let!(:res1) { create :reservation, screening_id: screening.id, status: 'confirmed' }
    let!(:res2) { create :reservation, screening_id: screening.id, status: 'confirmed' }
    let!(:res3) { create :reservation, screening_id: screening.id, status: 'confirmed' }

    subject { instance.unpaid(screening.id) }

    it 'returns unpaid reservation for given screening' do
      expect(subject).to match_array([res1, res2, res3])
    end
  end
end
