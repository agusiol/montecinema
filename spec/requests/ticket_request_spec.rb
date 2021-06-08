# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tickets requests' do
  let!(:ticket) { create(:ticket) }

  describe 'GET /tickets' do
    it 'works and return status 200' do
      get("/reservations/#{ticket.reservation_id}/tickets")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /tickets/:id' do
    it 'works and return status 200' do
      get("/reservations/#{ticket.reservation_id}/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end
end
