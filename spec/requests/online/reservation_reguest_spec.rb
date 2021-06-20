# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Online Reservations requests' do
  let!(:screening) { create(:screening) }
  let!(:user) { create(:user) }
  let!(:res1) {create :reservation, user_id: user.id}
  let!(:ticket) {create :ticket, reservation_id: res1.id}
  let!(:res2) {create :reservation}

  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  let(:auth_headers)  {Devise::JWT::TestHelpers.auth_headers(headers, user)}
  

  describe 'GET /reservations' do

    before { get("/online/reservations", headers: auth_headers)}

    it 'works and return status 200' do
      expect(response.status).to eq(200)
    end

    it 'renders only reservation for loged in user' do
      expect(response.body).to include("#{res1.id}")
      expect(response.body).not_to include("#{res2.id}")
    end

  end

  describe 'GET /reservations/:id' do

  
    context "when reservation belongs to current user" do
      before { get("/online/reservations/#{res1.id}", headers: auth_headers) }

        it 'works and return status 200' do
          expect(response.status).to eq(200)
        end

        it 'rensers reservation' do
          expect(response.body).to include("#{res1.id}")
        end
      end
    
    context "when reservation does not belog to current user" do
      before {get("/online/reservations/#{res2.id}", headers: auth_headers)}


        it 'does not render reservation' do
          expect(response.body).to eq("{\"message\":\"You are not allowed to access!\"}")
          expect(response.body).not_to include("#{res2.id}")
        end
      end
    

  end

  describe 'POST /reservations' do
    let(:seat) {'4A'}
    let(:tickets) do [
      { "price": 15, "ticket_type": 'normal', "seat": seat },
      { "price": 15, "ticket_type": 'normal', "seat": '4B' },
      { "price": 15, "ticket_type": 'normal', "seat": '4C' },

    ] 
    end 
    let(:params) { {reservation: { screening_id: screening.id, tickets: tickets } }.to_json }
    

    subject {post("/online/reservations", headers: auth_headers, params: params)}
  
    it 'works and return status 201' do
      subject
      expect(response.status).to eq(201)
    end

    it 'creates reservation and tickets' do
      expect{subject}.to change { Reservation.count }.by(1)  && change  { Ticket.count }.by(3)
    end

    context "when ticket's seat unavialable" do
      let(:seat) {'100D'}
      it "render error message" do
        subject
        expect(response.body).to eq("{\"error\":\"Provided seats are not available!\"}")
      end
    end

  end


  describe 'DELETE /reservations/:id' do
    
    context 'when reservation belongs to the user' do 
      before {delete("/online/reservations/#{res1.id}", headers: auth_headers)}
      
      it 'works and return status 200' do
        expect(response.status).to eq(200)
      end
      it 'delettets the reservation'  do
        expect(Reservation.exists?(res1.id)).to eq(false)
      end
    end

    context 'when reservation does NOT belong to the user' do 
      before {delete("/online/reservations/#{res2.id}", headers: auth_headers)}
      
      it 'works and return status 401' do
        expect(response.status).to eq(401)
      end
      it 'does not deletes the reservation'  do
        expect(Reservation.exists?(res1.id)).to eq(true)
      end
    end
    
  end
end
