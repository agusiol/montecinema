# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Screening requests' do
  let!(:screening) { create(:screening) }

  describe 'GET /cinema_halls/hall_id/movies/movie_id/screenings' do
    it 'works and return status 200' do
      get("/movies/#{screening.movie_id}/screenings")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /cinema_halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      get("/movies/#{screening.movie_id}/screenings/#{screening.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /cinema_halls/hall_id/movies/movie_id/screenings' do
    it 'works and return status 201' do
      post("/movies/#{screening.movie_id}/screenings",
           params: { screening:
             { date: '2021-07-25T15:30:00',
               cinema_hall_id: screening.cinema_hall_id,
               movie_id: screening.movie_id } })

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /cinema_halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      put("/movies/#{screening.movie_id}/screenings/#{screening.id}",
          params: { screening: { id: screening.id, date: '2021-07-21T20:30:00' } })

      expect(response.status).to eq(200)
    end
  end

  describe '/cinema_halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      delete("/movies/#{screening.movie_id}/screenings/#{screening.id}")
      expect(response.status).to eq(200)
    end
  end
end
