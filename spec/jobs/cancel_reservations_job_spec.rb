require 'rails_helper'

RSpec.describe CancelReservationsJob, type: :job do
  subject(:run_job) { described_class.perform_later(screening_id) }
  let(:screening_id) { 1 }

  before do
    allow(Reservations::UseCases::CancelUnpaidReservations).to receive(:call)
    run_job
  end

  it 'runs CancelUnpaidReservations use case' do
    expect(Reservations::UseCases::CancelUnpaidReservations).to have_received(:call).with(params: screening_id)
  end
end
