
require 'rails_helper'

RSpec.describe Screenings::UseCases::Create do
  let(:movie) {create :movie}
  let(:cinema_hall) {create :cinema_hall}
  let(:date) { Time.current + 40.minutes }
  let(:instance) { described_class.new }
  let(:params) do
    {
      date: date,
      movie_id: movie.id,
      cinema_hall_id: cinema_hall.id
    }
  end

  subject { instance.call(params: params) }

  describe '.call' do
    context 'when params valid'
      it 'creates new Screening' do
        expect { subject }.to change { Screening.count }.by(1)
      end

      it 'returns Screening object' do
        expect(subject).to be_a_kind_of(Screening)
      end

      it 'returns Screening object with proper attributes' do
        expect(subject).to have_attributes(params)
      end

      it 'returns object without errors' do
        expect(subject.errors).to match_array([])
      end

      it "enqueues cancel unpaid reservations process" do
        ActiveJob::Base.queue_adapter = :test
        expect { CancelReservationsJob.perform_later('screening.id')
               }.to have_enqueued_job
      end

    context 'when params invalid' do
      let(:date) { nil }

      it 'returns object with errors' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end