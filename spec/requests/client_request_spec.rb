require 'rails_helper'
RSpec.describe 'Clienrs requests' do
  let!(:client) { Client.create(email: 'example@email.com', name: 'Some name', age: 17) }

  describe 'GET /clients' do
    it 'works and return status 200' do
      get('/clients')
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /clients/:id' do
    it 'works and return status 200' do
      get("/clients/#{client.id}")
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /clients' do
    it 'works and return status 201' do
      post('/clients', params: { client: { email: 'example@email.com', name: 'Some name', age: 17 } })
      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /clients/:id' do
    it 'works and return status 200' do
      put("/clients/#{client.id}", params: { client: { id: client.id, name: 'Some other name' } })
      expect(response.status).to eq(200)
    end
  end

  describe 'DELETE /clients/:id' do
    it 'works and return status 200' do
      delete("/clients/#{client.id}")
      expect(response.status).to eq(200)
    end
  end
end
