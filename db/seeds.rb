# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

cinema_hall1 = CinemaHall.create(id: 1, name: 'Number 1', capacity: 200,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(200).call)
cinema_hall2 = CinemaHall.create(id: 2, name: 'Number 2', capacity: 100,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(100).call)
cinema_hall3 = CinemaHall.create(id: 3, name: 'Number 3', capacity: 50,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(50).call)

movie1 = Movie.create(id: 1, title: 'Shrek', genre: 'cartoon', age_allowed: 10, duration: 120)
movie2 = Movie.create(id: 2, title: 'Star Wars', genre: 'fantasy', age_allowed: 16, duration: 180)
movie3 = Movie.create(id: 3, title: 'The Accountant', genre: 'crime', age_allowed: 16, duration: 140)

screening1 = Screening.create(id: 1,
                              date: DateTime.parse('04/06/2021 18:30:00'),
                              cinema_hall_id: cinema_hall1.id,
                              movie_id: movie1.id)
screening2 = Screening.create(id: 2,
                              date: DateTime.parse('13/06/2021 19:00'),
                              cinema_hall_id: cinema_hall2.id,
                              movie_id: movie2.id)
screening3 = Screening.create(id: 3,
                              date: DateTime.parse('13/06/2021 20:00'),
                              cinema_hall_id: cinema_hall3.id,
                              movie_id: movie3.id)

Client.create(id: 1, name: 'Jan kowalski', email: 'jankowalski@mail.com', age: 16, real_user: false)
client2 = Client.create(id: 2, name: 'Agnieszka Kowalska', email: 'agnieszkakowalska@mail.com', age: 21,
                        real_user: true)
client3 = Client.create(id: 3, name: 'Janina Kowalska', email: 'janinakowalska@mail.com', age: 12, real_user: true)

ticket_desk1 = TicketDesk.create(id: 1, category: 'offline')
ticket_desk2 = TicketDesk.create(id: 2, category: 'offline')

Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screening1.id,
    ticket_desk_id: ticket_desk1.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '1A' },
      { price: 25,  ticket_type: 'full', seat: '1B' },
      { price: 25,  ticket_type: 'full', seat: '1C' },
      { price: 15,  ticket_type: 'discounted', seat: '1D' },
      { price: 15,  ticket_type: 'discounted', seat: '1E' }
    ]
  }
)
Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screening1.id,
    ticket_desk_id: ticket_desk2.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '3A' },
      { price: 25,  ticket_type: 'full', seat: '3B' },
      { price: 25,  ticket_type: 'full', seat: '3C' }
    ]
  }
)

Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screening2.id,
    ticket_desk_id: ticket_desk2.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '3A' },
      { price: 25,  ticket_type: 'full', seat: '3B' },
      { price: 25,  ticket_type: 'full', seat: '3C' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    client_id: client2.id,
    screening_id: screening1.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '2A' },
      { price: 25,  ticket_type: 'full', seat: '2B' },
      { price: 25,  ticket_type: 'full', seat: '2C' },
      { price: 15,  ticket_type: 'discounted', seat: '2D' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    client_id: client3.id,
    screening_id: screening1.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '5C' },
      { price: 15,  ticket_type: 'discounted', seat: '5D' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    client_id: client2.id,
    screening_id: screening3.id,
    tickets: [
      { price: 25,  ticket_type: 'full', seat: '2A' },
      { price: 25,  ticket_type: 'full', seat: '2B' },
      { price: 25,  ticket_type: 'full', seat: '2C' },
      { price: 15,  ticket_type: 'discounted', seat: '2D' }
    ]
  }
)
