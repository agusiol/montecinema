require 'rails_helper'

RSpec.describe CancelReservationsJob, type: :job do
  let(:cinema_hall) {create(:cinema_hall)}
  let(:movie) {create(:movie)}
  let(:screening) {create(:screening, date: Time.current - 30.minutes, movie: movie, cinema_hall: cinema_hall) }
  let(:cancel_unpaid_reservations) { instance_double(Reservations::UseCases::CancelUnpaidReservations, call: true) }

  it "runs CancelUnpaidReservations use case" do
    expect(Reservations::UseCases::CancelUnpaidReservations).to receive(:new).and_return(cancel_unpaid_reservations)
    expect(cancel_unpaid_reservations).to receive(:call).with(screening.id)
  end
end

