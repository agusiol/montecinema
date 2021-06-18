# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Offline Reservations requests' do
  let!(:hall) { create(:cinema_hall) }
  let!(:movie) { create(:movie) }
  let!(:screening) { create(:screening, movie: movie, cinema_hall: hall) }
  let!(:desk) { create(:ticket_desk) }
  let!(:offline_user) { create :user, real_user: false }
  let!(:res) { create(:reservation, screening_id: screening.id, ticket_desk_id: desk.id) }
  let!(:user) { create(:user, role: 2) }

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let(:auth_headers)  {Devise::JWT::TestHelpers.auth_headers(headers, user)}
  

  describe 'GET /reservations' do
    it 'works and return status 200' do
      get("/offline/reservations", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /reservations/:id' do
    it 'works and return status 200' do
      get("/offline/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /reservations' do
    let(:tickets) do [
      { "price": 15, "ticket_type": 'normal', "seat": '2A' },
      { "price": 15, "ticket_type": 'normal', "seat": '2B' },
      { "price": 15, "ticket_type": 'normal', "seat": '2C' },
      { "price": 15, "ticket_type": 'normal', "seat": '2D' },
      { "price": 15, "ticket_type": 'normal', "seat": '2E' }
    ] 
  end 

    let(:params) do
    {reservation: 
        {status: 'paid', 
        screening_id: screening.id, 
        ticket_desk_id: desk.id,
        tickets: tickets
      }}.to_json
    end 
  

      
  
    it 'works and return status 201' do
      post("/offline/reservations", headers: auth_headers, params: params)

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /reservations/:id' do
    let(:raw_params) {{ id: res.id, status: 'paid' }.to_json}
    it 'works and return status 200' do
      put("/offline/reservations/#{res.id}", headers: auth_headers, params: raw_params)
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /reservations/:id' do
    it 'works and return status 200' do
      delete("/offline/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end
end
