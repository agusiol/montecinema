# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'Offline Reservations requests' do
  let!(:screening) { create(:screening) }
  let!(:desk) { create(:ticket_desk) }
  let!(:offline_user) { create :user, real_user: false }
  let!(:res) { create(:reservation, screening_id: screening.id, ticket_desk_id: desk.id, status: 'confirmed') }
  let!(:res2) { create :reservation}
  let!(:res3) { create :reservation}
  let!(:employee) { create(:user, role: 1) }

  context 'when user is  admin/employee' do
    let!(:employee) { create(:user, role: 1) }
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    let!(:auth_headers)  { Devise::JWT::TestHelpers.auth_headers(headers, employee) }

    describe 'GET /reservations' do
      it 'it returns status 200' do
        get('/offline/reservations', headers: auth_headers)
        expect(response.status).to eq(200)
      end
    end

    describe 'GET /reservations/:id' do
      it 'works and return status 200' do
        get("/offline/reservations/#{res.id}", headers: auth_headers)
        expect(response.status).to eq(200)
      end
    end

    describe 'POST /reservations' do
      let(:tickets) do
        [
          { "price": 15.99, "ticket_type": 'normal', "seat": '2A' },
          { "price": 15.99, "ticket_type": 'normal', "seat": '2B' },
          { "price": 15.99, "ticket_type": 'normal', "seat": '2C' },
          { "price": 7.99, "ticket_type": 'student', "seat": '2D' },
          { "price": 7.99, "ticket_type": 'student', "seat": '2E' }
        ]
      end

      let(:params) do
        { reservation:
            { status: 'paid',
              screening_id: screening.id,
              ticket_desk_id: desk.id,
              tickets: tickets } }.to_json
      end

      subject { post('/offline/reservations', headers: auth_headers, params: params) }

      it 'works and return status 201' do
        subject
        expect(response.status).to eq(201)
      end

      it 'creates reservation and tickets' do
        expect { subject }.to change { Reservation.count }.by(1) && change { Ticket.count }.by(5)
      end
    end

    describe 'PUT /reservations/:id' do
      let(:params) { { id: res.id }.to_json }
      subject { put("/offline/reservations/#{res.id}", headers: auth_headers, params: params) }

      it 'works and return status 200' do
        subject
        expect(response.status).to eq(200)
      end

      it 'changes the reservations status to paid' do
        expect { subject }.to change { res.reload.status }.from('confirmed').to('paid')
      end
    end

    describe 'DELETE /reservations/:id' do
      before { delete("/offline/reservations/#{res.id}", headers: auth_headers) }
      it 'works and return status 200' do
        expect(response.status).to eq(200)
      end
      it 'delettets the reservation' do
        expect(Reservation.exists?(res.id)).to eq(false)
      end
    end
  end

  context 'when user is NOT  admin/employee' do
    let!(:user) { create(:user, role: 0) }
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    let!(:auth_headers)  { Devise::JWT::TestHelpers.auth_headers(headers, user) }

    describe 'GET /reservations' do
      it 'returns status 401' do
        get('/offline/reservations', headers: auth_headers)
        expect(response.status).to eq(401)
      end
    end

    describe 'GET /reservations/:id' do
      it 'returns status 401' do
        get("/offline/reservations/#{res.id}", headers: auth_headers)
        expect(response.status).to eq(401)
      end
    end

    describe 'POST /reservations' do
      let(:tickets) { [{ "price": 15, "ticket_type": 'normal', "seat": '2A' }] }
      let(:params) do
        { reservation:
            { status: 'paid',
              screening_id: screening.id,
              ticket_desk_id: desk.id,
              tickets: tickets } }.to_json
      end

      subject { post('/offline/reservations', headers: auth_headers, params: params) }

      it 'returns status 401' do
        subject
        expect(response.status).to eq(401)
      end

      it 'does not create reservation' do
        expect { subject }.not_to change { Reservation.count } && change { Ticket.count }
      end
    end

    describe 'PUT /reservations/:id' do
      let(:raw_params) { { id: res.id }.to_json }
      subject { put("/offline/reservations/#{res.id}", headers: auth_headers, params: raw_params) }
      it 'returns status 401' do
        subject
        expect(response.status).to eq(401)
      end
      it 'does not change the reservation status to paid' do
        expect { subject }.not_to change { res.reload.status }
      end
    end

    describe 'DELETE /reservations/:id' do
      it 'returns status 401' do
        delete("/offline/reservations/#{res.id}", headers: auth_headers)
        expect(response.status).to eq(401)
      end
      it 'does not deletes the reservation' do
        expect(Reservation.exists?(res.id)).to eq(true)
      end
    end
  end
end
