# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reservations requests' do
  let!(:hall) { create(:cinema_hall) }
  let!(:movie) { create(:movie) }
  let!(:user) { create(:user) }
  let!(:screening) { create(:screening, movie: movie, cinema_hall: hall) }
  let!(:desk) { create(:ticket_desk) }
  let!(:res) { create(:reservation, screening_id: screening.id, ticket_desk_id: desk.id, user_id: user.id) }

  describe 'GET /reservations' do
    it 'works and return status 200' do
      get("/movies/#{movie.id}/screenings/#{screening.id}/reservations")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /reservations/:id' do
    it 'works and return status 200' do
      get("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /reservations/:id' do
    it 'works and return status 200' do
      put("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}",
          params: { reservation: { id: res.id, status: 'paid' } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /reservations/:id' do
    it 'works and return status 200' do
      delete("/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end
end
