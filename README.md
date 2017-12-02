# Site
https://exchange-system.herokuapp.com

* Ruby version
2.4.0p0

* System dependencies

* Configuration

* Database creation
rake db:migrate
rake db:setup

* Database initialization
rake db:seed

* How to run the test suite
rails test

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
heroku login
heroku git:remote -a exchange-system
git push heroku master
