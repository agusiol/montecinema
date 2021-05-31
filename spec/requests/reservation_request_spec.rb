# require "rails_helper"

# RSpec.describe "Reservations requests" do
#   describe "GET /reservations" do
#     let!(:res) { Reservation.create(status: "new stayus", screening_id: "22", ticket_desk_id: "2" ) }

#     it "works and return status 200" do
#       get("/ticket_desks/21/screenings/20/reservations")
#       expect(response.status).to eq(200)
#     end
#   end

#   describe "GET /reservations/:id" do
#     let!(:res) { Reservation.create(status: "new stayus", screening_id: "22", ticket_desk_id: "2" ) }

#     it "works and return status 200" do
#       get("/ticket_desks/21/screenings/20/reservations/#{res.id}")
#       expect(response.status).to eq(200)
#     end
#   end

#   describe "POST /reservations" do
#     it "works and return status 201" do
#       post("/ticket_desks/2/screenings/22/reservations", params: { reservation: { status: "paid", screening_id: "22", ticket_desk_id: "2" } } )
#       expect(response.status).to eq(201)
#     end
#   end

#   describe "PUT /reservations/:id" do
#     let!(:res) { Reservation.create(status: "new stayus", screening_id: "22", ticket_desk_id: "2" ) }

#     it "works and return status 200" do
#       put("/ticket_desks/2/screenings/22/reservations/#{res.id}", params: { reservation: { id: res.id, status: "new type" } })
#       expect(response.status).to eq(200)
#     end
#   end

#   describe "DELETE /reservations/:id" do
#     let!(:res) { Reservation.create(status: "new stayus", screening_id: "20", ticket_desk_id: "21" ) }

#     it "works and return status 200" do
#       delete("/reservations/#{res.id}")
#       expect(response.status).to eq(200)
#     end
#   end
# end