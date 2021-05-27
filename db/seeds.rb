# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




cinema_hall_1 = CinemaHall.create(id: 1, name: "Number 1", capacity: 200)
cinema_hall_2 = CinemaHall.create(id: 2, name: "Number 2", capacity: 100)
cinema_hall_3 = CinemaHall.create(id: 3, name: "Number 3", capacity: 50)

movie_1 = Movie.create(id: 1, title: "Shrek", genre: "cartoon", age_allowed: 10, duration: 120)
movie_2 = Movie.create(id: 2, title: "Star Wars", genre: "fantasy", age_allowed: 16, duration: 180)
movie_3 = Movie.create(id: 3, title: "The Accountant", genre: "crime", age_allowed: 16, duration: 140)

screening_1 = Screening.create(id: 1, 
  date: DateTime.parse("13/06/2021 16:00"),
  cinema_hall_id: cinema_hall_1.id,
  movie_id: movie_1.id
)
screening_2 = Screening.create(id: 2, 
  date: DateTime.parse("13/06/2021 19:00"),
  cinema_hall_id: cinema_hall_2.id,
  movie_id: movie_2.id
)
screening_3 = Screening.create(id: 3, 
  date: DateTime.parse("13/06/2021 20:00"),
  cinema_hall_id: cinema_hall_3.id,
  movie_id: movie_3.id
)