# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Online Reservations requests' do
  let!(:screening) { create(:screening) }
  let!(:res) { create(:reservation, screening_id: screening.id) }
  let!(:user) { create(:user) }

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let(:auth_headers)  {Devise::JWT::TestHelpers.auth_headers(headers, user)}
  

  describe 'GET /reservations' do
    it 'works and return status 200' do
      get("/online/reservations", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'GET /reservations/:id' do
    it 'works and return status 200' do
      get("/online/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end

  describe 'POST /reservations' do
    let(:tickets) do [
      { "price": 15, "ticket_type": 'normal', "seat": '4A' },
      { "price": 15, "ticket_type": 'normal', "seat": '4B' },
      { "price": 15, "ticket_type": 'normal', "seat": '4C' },

    ] 
  end 

    let(:params) do
    {reservation: 
        {status: 'paid', 
        screening_id: screening.id, 
        tickets: tickets
      }}.to_json
    end 
  
  
    it 'works and return status 201' do
      post("/online/reservations", headers: auth_headers, params: params)

      expect(response.status).to eq(201)
    end
  end


  describe 'DELETE /reservations/:id' do
    it 'works and return status 200' do
      delete("/online/reservations/#{res.id}", headers: auth_headers)
      expect(response.status).to eq(200)
    end
  end
end
