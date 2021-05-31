require "rails_helper"

RSpec.describe "Tickets requests" do
  let!(:hall) { CinemaHall.create(name: "New name", capacity: 200) }
  let!(:movie) { Movie.create(title: "New title", genre: "example", age_allowed: 16, duration: 120) }
  let!(:screening) {Screening.create(date: "2021-07-21T15:30:00", cinema_hall_id: hall.id, movie_id: movie.id)}
  let!(:desk) { TicketDesk.create(type: "Some type") }
  let!(:res) { Reservation.create(status: "confirmed", screening_id: screening.id , ticket_desk_id: desk.id ) }
  let!(:ticket) {Ticket.create(type: "some type", price: 30, seat: "A1", reservation_id: res.id)}

  describe "GET /tickets" do
    it "works and return status 200" do
      get("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}/tickets")
      expect(response.status).to eq(200)
    end
  end

  describe "GET /tickets/:id" do
    it "works and return status 200" do
      get("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}/tickets")
      expect(response.status).to eq(200)
    end
  end

  describe "POST /tickets" do
    it "works and return status 201" do
      post("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}/tickets",
         params: { ticket: { type: "other type", price: 30, seat: "A2", reservation_id: res.id } } )
      expect(response.status).to eq(201)
    end
  end

  describe "PUT /tickets/:id" do
    it "works and return status 200" do
      put("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}/tickets/#{ticket.id}",
         params: { ticket: { id: ticket.id, seat: "A3" } })
      expect(response.status).to eq(200)
    end
  end

  describe "DELETE /tickets/:id" do
    it "works and return status 200" do
      delete("/ticket_desks/#{desk.id}/screenings/#{screening.id}/reservations/#{res.id}/tickets/#{ticket.id}")
      expect(response.status).to eq(200)
    end
  end
end