# README
# Monte Cinema

API app for reservation/tickets management in Cinema. It enables ticket purchase or reservation at ticket desks or reservation online.

## Requirments
ruby 3.0.1
rails 6.x
postgresql 13.x
redis
 
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


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
