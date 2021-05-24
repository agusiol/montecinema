require 'rails_helper'

RSpec.describe CinemaHallsController, type: :controller do
    describe 'GET #show' do
        it "shows cinema_hall when valid id" do
            cinema_hall = CinemaHall.create(name: "Kyoto", capacity: 100)
            get :show, params: {id: cinema_hall.id}
            expect(response.status).to eq(200)
        end

        it "responds with error when not valid id" do
            expect{get :show, params: {id: "bad_id"}}.to raise_error(ActiveRecord::RecordNotFound)
        end
         
        
    end
    describe 'POST #create' do
        
    end
end