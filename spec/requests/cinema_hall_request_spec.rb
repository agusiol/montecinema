# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'CinemaHalls requests' do
  let!(:hall) { create(:cinema_hall) }

  describe 'GET /cinema_halls' do
    it 'works and return status 200' do
      get('/cinema_halls')
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /cinema_halls/:id' do
    it 'works and return status 200' do
      get("/cinema_halls/#{hall.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /cinema_halls' do
    it 'works and return status 201' do
      post('/cinema_halls', params: { cinema_hall: { name: 'new name', capacity: 100 } })
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /cinema_halls/:id' do
    it 'works and return status 200' do
      put("/cinema_halls/#{hall.id}", params: { cinema_hall: { id: hall.id, name: 'new name' } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /cinema_halls/:id' do
    it 'deltes the record and return status 200' do
      delete("/cinema_halls/#{hall.id}")
      expect(response.status).to eq(200)
      expect(CinemaHall.exists?(hall.id)).to eq(false)
    end
  end
end
