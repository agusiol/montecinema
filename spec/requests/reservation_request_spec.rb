require "rails_helper"

RSpec.describe "Reservations requests" do
  let!(:hall) { CinemaHall.create(name: "New name", capacity: 200) }
  let!(:movie) { Movie.create(title: "New title", genre: "example", age_allowed: 16, duration: 120) }
  let!(:screening) {Screening.create(date: "2021-07-21T15:30:00", cinema_hall_id: hall.id, movie_id: movie.id)}
  let!(:desk) { TicketDesk.create(type: "Some type") }
  let!(:res) { Reservation.create(status: "confirmed", screening_id: screening.id , ticket_desk_id: desk.id ) }

  describe "GET /reservations" do
    it "works and return status 200" do
      get("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations")
      expect(response.status).to eq(200)
    end
  end

  describe "GET /reservations/:id" do
    it "works and return status 200" do
      get("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /reservations" do
    it "works and return status 201" do
      post("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations",
         params: { reservation: { status: "paid", screening_id: screening.id , ticket_desk_id: desk.id } } )
      expect(response.status).to eq(201)
    end
  end

  describe "PUT /reservations/:id" do
    it "works and return status 200" do
      put("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}",
         params: { reservation: { id: res.id, status: "cancelled" } })
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE /reservations/:id" do
    it "works and return status 200" do
      delete("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}")
      expect(response.status).to eq(200)
    end
  end
end