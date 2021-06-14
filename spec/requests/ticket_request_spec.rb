# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tickets requests' do
  let!(:screening) { create(:screening) }
  let!(:client) { create(:client) }
  let!(:ticket_desk) { create(:ticket_desk) }
  let!(:reservation) { create(:reservation) }
  let!(:ticket) { create(:ticket, reservation_id: reservation.id) }

  describe 'GET /tickets' do
    it 'works and return status 200' do
      get("/movies/#{screening.movie.id}/screenings/#{screening.id}/reservations/#{ticket.reservation_id}/tickets")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /tickets/:id' do
    it 'works and return status 200' do
      get("/movies/#{screening.movie.id}/screenings/#{screening.id}/reservations/#{reservation.id}/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end
end
