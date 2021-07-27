require 'rails_helper'
RSpec.describe 'Movies requests' do
  let!(:movie1) { create :movie, title: "The Avengers" }
  let!(:movie2) { create :movie, title: "Avatar" }
  let!(:movie3) { create :movie, title: "Shrek" }

  describe 'GET /movies/search/:text' do
    it 'retunrns searched movie' do
      search_text = "Avatar"
      get("/movies/search/#{search_text}")
      expect(JSON.parse(response.body).length).to eql(1)
      expect(JSON.parse(response.body)[0]["title"]).to eql(movie2.title)
    end

    it 'returns an array with movies matching search text' do
      search_text = "av"
      get("/movies/search/#{search_text}")
      expect(JSON.parse(response.body).length).to eql(2)
    end

    it 'returns an empty array when no matching movies' do
      search_text = "Bond"
      get("/movies/search/#{search_text}")
      expect(JSON.parse(response.body).length).to eql(0)

      
    end
  end
end