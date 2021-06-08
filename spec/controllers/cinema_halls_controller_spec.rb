# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CinemaHallsController, type: :controller do
  context 'when valid ID' do
    it 'shows cinema_hall' do # => consider if this description is valid, cause I did not see that you testing inside this block that cinema_hall are shown, from my perspective you testing if response status is 200 :)
      cinema_hall = CinemaHall.create(name: 'Kyoto', capacity: 100)
      get :show, params: { id: cinema_hall.id }
      expect(response.status).to eq(200)
      expect(response.body).to include('Kyoto')
      # expect(JSON.parse(response.body)).to eq( { id: cinema_hall.id, name: cinema_hall.name, capacity: cinema_hall.capacity })
    end
  end

  context 'when not valid ID' do
    it 'responds with error' do
      expect { get :show, params: { id: 'bad_id' } }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #create' do
  end
end
