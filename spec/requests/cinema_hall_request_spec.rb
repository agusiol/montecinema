require "rails_helper"
RSpec.describe "CinemaHalls requests" do
  let!(:hall) { CinemaHall.create(name: "New name", capacity: 200) }

  describe "GET /cinema-halls" do
    it "works and return status 200" do
      get("/cinema-halls")
      expect(response.status).to eq(200)
    end
  end

  describe "GET /cinema-halls/:id" do
    it "works and return status 200" do
      get("/cinema-halls/#{hall.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /cinema-halls" do
    it "works and return status 201" do
      post("/cinema-halls", params: { cinema_hall: {  name: "new name", capacity: 100 } } )
      expect(response.status).to eq(201)
    end
  end

  describe "PUT /cinema-halls/:id" do
    it "works and return status 200" do
      put("/cinema-halls/#{hall.id}", params: { cinema_hall: { id: hall.id, name: "new name" } })
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE /cinema-halls/:id" do
    it "works and return status 200" do
      delete("/cinema-halls/#{hall.id}")
      expect(response.status).to eq(200)
      expect(CinemaHall.find_by(id: hall.id).to eq(nil))
    end
  end
end