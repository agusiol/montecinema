# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'TicketDesks requests' do
  let!(:desk) { create(:ticket_desk) }
  let!(:user) { create(:user, role: 2) }

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let!(:auth_headers)  { Devise::JWT::TestHelpers.auth_headers(headers, user) }

  describe 'GET /ticket_desks' do
    it 'works and return status 200' do
      get('/ticket_desks', headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /ticket_desks/:id' do
    it 'works and return status 200' do
      get("/ticket_desks/#{desk.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /ticket_desks' do
    let!(:params) { { ticket_desk: { ticket_type: 'normal' } }.to_json }
    it 'works and return status 201' do
      post('/ticket_desks', headers: auth_headers, params: params)
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /ticket_desks/:id' do
    let!(:params) { { ticket_desk: { id: desk.id, ticket_type: 'child' } }.to_json }
    it 'works and return status 200' do
      put("/ticket_desks/#{desk.id}", headers: auth_headers, params: params)
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /ticket_desks/:id' do
    it 'works and return status 200' do
      delete("/ticket_desks/#{desk.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end
end
