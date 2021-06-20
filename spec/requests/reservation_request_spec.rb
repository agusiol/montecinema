# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reservations requests' do
  let!(:movie) { create(:movie) }
  let!(:user) { create(:user) }
  let!(:screening) { create(:screening, movie: movie) }
  let!(:desk) { create(:ticket_desk) }
  let!(:res) { create(:reservation, screening_id: screening.id, ticket_desk_id: desk.id, user_id: user.id) }
  let!(:admin) { create(:user, role: 2) }

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let!(:auth_headers)  {Devise::JWT::TestHelpers.auth_headers(headers, admin)}

  describe 'GET /reservations' do
    it 'works and return status 200' do
      get("/movies/#{movie.id}/screenings/#{screening.id}/reservations", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /reservations/:id' do
    it 'works and return status 200' do
      get("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /reservations/:id' do
    let!(:params) {{ reservation: { id: res.id, status: 'paid' } }.to_json}
    it 'works and return status 200' do
      put("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}", headers: auth_headers,
          params: params)
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /reservations/:id' do
    it 'works and return status 200' do
      delete("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end
end
