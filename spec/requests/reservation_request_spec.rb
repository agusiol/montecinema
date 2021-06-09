# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reservations requests' do
  let!(:hall) { create(:cinema_hall) }
  let!(:movie) { create(:movie) }
  let!(:client) { create(:client) }
  let!(:screening) { create(:screening, movie: movie, cinema_hall: hall) }
  let!(:desk) { create(:ticket_desk) }
  let!(:res) { create(:reservation, screening_id: screening.id, ticket_desk_id: desk.id, client_id: client.id) }

  describe 'GET /reservations' do
    it 'works and return status 200' do
      get("/ticket_desks/#{desk.id}/movies/#{movie.id}/screenings/#{screening.id}/reservations")
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /reservations/:id' do
    it 'works and return status 200' do
      get("/ticket_desks/#{desk.id}/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /reservations' do
    it 'works and return status 201' do
      post("/ticket_desks/#{desk.id}/movies/#{movie.id}/screenings/#{screening.id}/reservations",
           params:{ reservation: { status: 'paid', screening_id: screening.id, ticket_desk_id: desk.id, client_id: client.id, 
            tickets: [
              { "price": 15, "ticket_type": "normal", "seat": "2A" },
              { "price": 15, "ticket_type": "normal", "seat": "2B" },
              { "price": 15, "ticket_type": "normal", "seat": "2C" },
              { "price": 15, "ticket_type": "normal", "seat": "2D" },
              { "price": 15, "ticket_type": "normal", "seat": "2E" } 
              ]
              }
            })

      expect(response.status).to eq(200)
    end
  end

  describe 'PUT /reservations/:id' do
    it 'works and return status 200' do
      put("/ticket_desks/#{desk.id}/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}",
          params: { reservation: { id: res.id, status: 'paid' } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /reservations/:id' do
    it 'works and return status 200' do
      delete("/ticket_desks/#{desk.id}/movies/#{movie.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end
end
