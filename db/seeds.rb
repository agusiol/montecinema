# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

CinemaHall.create(id: 1, name: 'Number 1', capacity: 200,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(200).call)
CinemaHall.create(id: 2, name: 'Number 2', capacity: 100,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(100).call)
CinemaHall.create(id: 3, name: 'Number 3', capacity: 50,
                                 seats: CinemaHalls::UseCases::GenerateSeats.new(50).call)
Movie.create(id: 1, title: 'Shrek', genre: 'cartoon', age_allowed: 10, duration: 120)
Movie.create(id: 2, title: 'Star Wars', genre: 'fantasy', age_allowed: 16, duration: 180)
Movie.create(id: 3, title: 'The Accountant', genre: 'crime', age_allowed: 16, duration: 140)

screenings = (1..20).map do |id|
  
  date = rand(Time.current..Time.current + 7.days)
  movie_id = rand(1..3)
  cinema_hall_id = rand(1..3)

  Screening.create(
    id: id,
    date: date,
    cinema_hall_id: cinema_hall_id,
    movie_id: movie_id
  )
end


user1 = User.create(id: 1, name: 'Jan kowalski', email: 'jankowalski@mail.com', password: 'savepassword',
                    real_user: false)
user2 = User.create(id: 2, name: 'Agnieszka Kowalska', email: 'agnieszkakowalska@mail.com', password: 'savepassword',
                    real_user: true)
user3 = User.create(id: 3, name: 'Janina Kowalska', email: 'janinakowalska@mail.com', password: 'savepassword',
                    real_user: true)
User.create(id: 4, name: 'Employee', email: 'employee@mail.com', password: 'employee',role: 1)
User.create(id: 5, name: 'Admin', email: 'admin@mail.com', password: 'adminadmin',role: 2)   

ticket_desk1 = TicketDesk.create(id: 1, category: 'offline')
ticket_desk2 = TicketDesk.create(id: 2, category: 'offline')

Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screenings[1].id,
    user_id: user1.id,
    ticket_desk_id: ticket_desk1.id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '1A' },
      { price: 25.99,  ticket_type: 'normal', seat: '1B' },
      { price: 25.99,  ticket_type: 'normal', seat: '1C' },
      { price: 15.99,  ticket_type: 'student', seat: '1D' },
      { price: 15.99,  ticket_type: 'student', seat: '1E' }
    ]
  }
)
Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screenings[1].id,
    user_id: user1.id,
    ticket_desk_id: ticket_desk2.id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '3A' },
      { price: 25.99,  ticket_type: 'normal', seat: '3B' },
      { price: 25.99,  ticket_type: 'normal', seat: '3C' }
    ]
  }
)

Reservations::UseCases::CreateOffline.new.call(
  params: {
    status: 'paid',
    screening_id: screenings[0].id,
    user_id: user1.id,
    ticket_desk_id: ticket_desk2.id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '3A' },
      { price: 25.99,  ticket_type: 'normal', seat: '3B' },
      { price: 25.99,  ticket_type: 'normal', seat: '3C' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    user_id: user2.id,
    screening_id: screenings[1].id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '2A' },
      { price: 25.99,  ticket_type: 'normal', seat: '2B' },
      { price: 25.99,  ticket_type: 'normal', seat: '2C' },
      { price: 15.99,  ticket_type: 'student', seat: '2D' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    user_id: user3.id,
    screening_id: screenings[1].id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '5C' },
      { price: 15.99,  ticket_type: 'student', seat: '5D' }
    ]
  }
)

Reservations::UseCases::CreateOnline.new.call(
  params: {
    status: 'confirmed',
    user_id: user2.id,
    screening_id: screenings[2].id,
    tickets: [
      { price: 25.99,  ticket_type: 'normal', seat: '2A' },
      { price: 25.99,  ticket_type: 'normal', seat: '2B' },
      { price: 25.99,  ticket_type: 'normal', seat: '2C' },
      { price: 15.99,  ticket_type: 'student', seat: '2D' }
    ]
  }
)
