require 'rails_helper'

RSpec.describe Reservations::UseCases::CancelUnpaidReservations do
  let(:screening) { create :screening }
  let(:instance) { described_class.new }
  let(:delete_use_case) { instance_double(Reservations::UseCases::Delete, call: true) }
  let(:mailer) { instance_double(ReservationMailer.cancellation_email) }
  # ReservationMailer.with(reservation: reservation, email: client.email).cancellation_email.deliver_later

  before do
    allow(Reservations::UseCases::Delete).to receive(:new).and_return(delete_use_case)
  end

  describe '.call' do
    context 'unpaiid reservations exist' do
      let!(:reservation1) { create :reservation, status: 'confirmed', screening_id: screening.id }
      let!(:reservation2) { create :reservation, status: 'confirmed', screening_id: screening.id }

      it 'calls destroy usecase' do
        expect(delete_use_case).to receive(:call).with(id: reservation1.id)
        expect(delete_use_case).to receive(:call).with(id: reservation2.id)
        instance.call(screening.id)
      end

      it 'call cancelation email' do
        # not working, having trouble with that
        expect(mailer).to receive(:deliver_later).with(reservation: reservation1, email: reservation.client.email)
      end
    end
  end
end
