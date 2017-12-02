# Link
https://exchange-system.herokuapp.com

# API docs

headers:
 * session-token: users token

[POST]   /exchanges
params:
	user:
		passport: 			passport number
		firstname
		lastname
	transaction:
	    currency_from_id: 	id of "from" currency,
	    currency_to_id: 	id of "to" currency,
	    amount: 			amount in "from" currency

response:
	success: true/false
    data:
        currency_from_amount: 	amount of sold currency
        currency_to_amount: 	amount of bought currency
	error: 	 transaction creating error
	message: full errors messages

[GET]    /currencies

# Other

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
