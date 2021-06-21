# README
# Monte Cinema

API app for reservation/tickets management in Cinema. It enables ticket purchase or reservation at ticket desks or reservation online.

## Requirments
* ruby 3.0.1
* rails 6.x
* postgresql 13.x
* redis
 
## Set Up

To install the gems required by the application:
```bash
bundle install
```
Set up your PostgreSQL config, then run:

```bash
rails db:create
rails db:migrate
rails db:seed
```

Run server
Start the Rails app:
```bash
bundle exec rails s 
bundle exec sidekiq 

```

Now You can find your app by pointing your browser to http://localhost:3000/

## Documentation
API documnetation can be found at http://localhost:3000/apipie or https://github.com/agusiol/montecinema/blob/main/doc/apidoc/schema_apipie.json

## Heroku
https://monte-cinema-aga.herokuapp.com/
## What should be improved?

* 30 minutes before screening time reservations should not be deleted from the database. Instead the status should change to cancelled, tickets from this reservation should also have some way of being disabled instead of deleted.

* CancelReservationsJob is now set for screening 30 minutes before its start. Probably it would work better and were more reliable if the cancellation job would be set for each reservation separately 

* Maybe some restriction for max 1 reservation for screening per client?

* CinemaHall seats should be refactored to consider different strutures of seats available in halls.

* User controller with only admin access for administration missing

* Reservation should have some random generated verification numer or string so it can be found and verified at ticket desk

* More advanced filters to search movies/screenings

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
