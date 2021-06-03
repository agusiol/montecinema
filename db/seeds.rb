# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




cinema_hall_1 = CinemaHall.create(id: 1, name: "Number 1", capacity: 200, seats: CinemaHalls::UseCases::GenerateSeats.new(200).call)
cinema_hall_2 = CinemaHall.create(id: 2, name: "Number 2", capacity: 100, seats: CinemaHalls::UseCases::GenerateSeats.new(100).call)
cinema_hall_3 = CinemaHall.create(id: 3, name: "Number 3", capacity: 50, seats: CinemaHalls::UseCases::GenerateSeats.new(50).call)

movie_1 = Movie.create(id: 1, title: "Shrek", genre: "cartoon", age_allowed: 10, duration: 120)
movie_2 = Movie.create(id: 2, title: "Star Wars", genre: "fantasy", age_allowed: 16, duration: 180)
movie_3 = Movie.create(id: 3, title: "The Accountant", genre: "crime", age_allowed: 16, duration: 140)

screening_1 = Screening.create(id: 1, 
  date: DateTime.parse("02/06/2021 14:50"),
  cinema_hall_id: cinema_hall_1.id,
  movie_id: movie_1.id,
  available_seats: cinema_hall_1.seats
)
screening_2 = Screening.create(id: 2, 
  date: DateTime.parse("13/06/2021 19:00"),
  cinema_hall_id: cinema_hall_2.id,
  movie_id: movie_2.id,
  available_seats: cinema_hall_2.seats
)
screening_3 = Screening.create(id: 3, 
  date: DateTime.parse("13/06/2021 20:00"),
  cinema_hall_id: cinema_hall_3.id,
  movie_id: movie_3.id,
  available_seats: cinema_hall_3.seats
)

client_1 = Client.create(id: 1, name: "Jan kowalski", email: "jankowalski@mail.com", age:16)
client_2 = Client.create(id: 2, name: "Agnieszka Kowalska", email: "agnieszkakowalska@mail.com", age:21)
client_3 = Client.create(id: 3, name: "Janina Kowalska", email: "janinakowalska@mail.com", age:12)

ticket_desk_1 = TicketDesk.create(id: 1, type: "offline")
ticket_desk_2 = TicketDesk.create(id: 2, type: "online")

reservation_1 = Reservation.create(id: 1, status: "confirmed", screening_id: screening_1.id, ticket_desk_id: ticket_desk_1.id, client_id: client_1.id)
reservation_2 = Reservation.create(id: 2, status: "confirmed", screening_id: screening_1.id, ticket_desk_id: ticket_desk_1.id, client_id: client_2.id)
reservation_3 = Reservation.create(id: 3, status: "paid", screening_id: screening_1.id, ticket_desk_id: ticket_desk_1.id, client_id: client_3.id)


ticket_1 = Ticket.create(id: 1, type: "full", price: 15.99, seat: "1A", reservation_id: reservation_1.id)
ticket_2 = Ticket.create(id: 2, type: "full", price: 15.99, seat: "2A", reservation_id: reservation_2.id)
ticket_3 = Ticket.create(id: 3, type: "full", price: 15.99, seat: "3A", reservation_id: reservation_3.id)

