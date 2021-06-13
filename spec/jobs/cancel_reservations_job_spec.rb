# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CancelReservationsJob, type: :job do
  let(:screening) { create(:screening, date: Time.current + 20.minutes) }
  let(:instance) { described_class.new(screening.id) }
  let(:delete_use_case) { instance_double(Reservations::UseCases::Delete, call: true) }
  let(:mailer) { instance_double(ReservationMailer.cancellation_email) }
  # ReservationMailer.with(reservation: reservation, email: client.email).cancellation_email.deliver_later

  before do
    allow(Reservations::UseCases::Delete).to receive(:new).and_return(delete_use_case)
  end

  describe '.perform' do
    it "enqueues cancel unpaid reservations process" do
      ActiveJob::Base.queue_adapter = :test
      expect { CancelReservationsJob.perform_later(screening.id)
             }.to have_enqueued_job
    end
    context 'unpaiid reservations exist' do
      let!(:reservation1) { create :reservation, status: 'confirmed', screening_id: screening.id }
      let!(:reservation2) { create :reservation, status: 'confirmed', screening_id: screening.id }

      it 'calls destroy usecase' do
        expect(delete_use_case).to receive(:call).with(id: reservation1.id)
        expect(delete_use_case).to receive(:call).with(id: reservation2.id)
        instance.perform_now
      end
    end
  end

      # it 'call cancelation email' do
      #   # not working, having trouble with that
      #   expect(mailer).to receive(:deliver_later).with(reservation: reservation1, email: reservation.client.email)
      # end
end
