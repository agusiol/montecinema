# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TicketDesks requests' do
  let!(:desk) { create(:ticket_desk) }
  describe 'GET /ticket_desks' do
    it 'works and return status 200' do
      get('/ticket_desks')
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /ticket_desks/:id' do
    it 'works and return status 200' do
      get("/ticket_desks/#{desk.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /ticket_desks' do
    it 'works and return status 201' do
      post('/ticket_desks', params: { ticket_desk: { ticket_type: 'normal' } })
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /ticket_desks/:id' do
    it 'works and return status 200' do
      put("/ticket_desks/#{desk.id}", params: { ticket_desk: { id: desk.id, ticket_type: 'child' } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /ticket_desks/:id' do
    it 'works and return status 200' do
      delete("/ticket_desks/#{desk.id}")
      expect(response.status).to eq(200)
    end
  end
end
