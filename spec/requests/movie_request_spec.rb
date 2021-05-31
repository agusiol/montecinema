require "rails_helper"
RSpec.describe "Movies requests" do
  let!(:movie) { Movie.create(title: "New title", genre: "example", age_allowed: 16, duration: 120) }

  describe "GET /movies" do
    it "works and return status 200" do
      get("/movies")
      expect(response.status).to eq(200)
    end
  end

  describe "GET /movies/:id" do
    it "works and return status 200" do
      get("/movies/#{movie.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /movies" do
    it "works and return status 201" do
      post("/movies", params: { movie: {  title: "new title", genre: "example", age_allowed: 12, duration: 180 } } )
      expect(response.status).to eq(201)
    end
  end

  describe "PUT /movies/:id" do
    it "works and return status 200" do
      put("/movies/#{movie.id}", params: { movie: { id: movie.id, title: "Other title" } })
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE /movies/:id" do
    it "works and return status 200" do
      delete("/movies/#{movie.id}")
      expect(response.status).to eq(200)
    end
  end
end