# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'CinemaHalls requests' do
  let!(:hall) { create(:cinema_hall) }
  let!(:user) { create(:user, role: 2) }

  before do
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    @auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  describe 'GET /cinema_halls' do
    it 'works and return status 200' do
      get('/cinema_halls', headers: @auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /cinema_halls/:id' do
    it 'works and return status 200' do
      get("/cinema_halls/#{hall.id}", headers: @auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /cinema_halls' do
    let(:params) { { name: 'Some name', capacity: 100 }.to_json }

    it 'works and return status 201' do
      post('/cinema_halls', headers: @auth_headers, params: params)
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /cinema_halls/:id' do
    let(:params) { { id: hall.id, name: 'new name' }.to_json }
    it 'works and return status 200' do
      put("/cinema_halls/#{hall.id}", headers: @auth_headers, params: params)
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /cinema_halls/:id' do
    it 'deltes the record and return status 200' do
      delete("/cinema_halls/#{hall.id}", headers: @auth_headers)
      expect(response.status).to eq(200)
      expect(CinemaHall.exists?(hall.id)).to eq(false)
    end
  end
end
