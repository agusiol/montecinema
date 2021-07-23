# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'Movies requests' do
  let!(:movie) { create(:movie) }
  let!(:admin) { create(:user, role: 2) }

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let!(:auth_headers)  { Devise::JWT::TestHelpers.auth_headers(headers, admin) }

  describe 'GET /movies' do
    it 'works and return status 200' do
      get('/movies')
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /movies/:id' do
    it 'works and return status 200' do
      get("/movies/#{movie.id}")
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)[0]["poster_url"]).to eq(movie.image_url)
    end
  end

  describe 'POST /movies' do
    let!(:params) do
      { movie:
        { title: 'new title',
          genre: 'example',
          age_allowed: 12,
          duration: 180,
          image: file } }.to_json
    end
    let!(:file) { Rack::Test::UploadedFile.new("spec/fixtures/files/test_poster.jpeg", "img/jpeg") }
   
    it 'works and return status 201' do
      post('/movies', headers: auth_headers, params: params)

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /movies/:id' do
    let!(:params) { { movie: { id: movie.id, title: 'Other title' } }.to_json }
    it 'works and return status 200' do
      put("/movies/#{movie.id}", headers: auth_headers, params: params)
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /movies/:id' do
    it 'works and return status 200' do
      delete("/movies/#{movie.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end
end
