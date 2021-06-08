require 'rails_helper'
RSpec.describe 'Screening requests' do
  let!(:hall) { CinemaHall.create(name: 'New name', capacity: 200) }
  let!(:movie) { Movie.create(title: 'New title', genre: 'example', age_allowed: 16, duration: 120) }
  let!(:screening) { Screening.create(date: '2021-07-21T15:30:00', cinema_hall_id: hall.id, movie_id: movie.id) }

  describe 'GET /cinema-halls/hall_id/movies/movie_id/screenings' do
    it 'works and return status 200' do
      get("/cinema-halls/#{hall.id}/movies/#{movie.id}/screenings")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /cinema-halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      get("/cinema-halls/#{hall.id}/movies/#{movie.id}/screenings/#{screening.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /cinema-halls/hall_id/movies/movie_id/screenings' do
    it 'works and return status 201' do
      post("//cinema-halls/#{hall.id}/movies/#{movie.id}/screenings",
           params: { screening:
             { date: '2021-07-25T15:30:00',
               cinema_hall_id: hall.id,
               movie_id: movie.id } })

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /cinema-halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      put("/cinema-halls/#{hall.id}/movies/#{movie.id}/screenings/#{screening.id}",
          params: { screening: { id: screening.id, date: '2021-07-21T20:30:00' } })

      expect(response.status).to eq(200)
    end
  end

  describe '/cinema-halls/hall_id/movies/movie_id/screenings/:id' do
    it 'works and return status 200' do
      delete("/cinema-halls/#{hall.id}/movies/#{movie.id}/screenings/#{screening.id}")
      expect(response.status).to eq(200)
    end
  end
end
