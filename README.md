# Welcome to Featureflow

Let your customers define your app workflow. See customer's feature requests,
bug reports and act on them.

## Setting up the app

- Clone the repo: `https://github.com/abeidahmed/featureflow2.git`
- `cd` into the project
- Run `bundle install` and `yarn install` to setup the dependencies
- Run `cp .sample.env .env` to create the `.env` file
- Setup your newly created `.env` with your credentials
- Run `rails db:setup` to setup the database
- Run `rails s` to start the rails server. You can also run `ruby ./bin/webpack-dev-server`
to start the webpack (optional). This will result in faster page reload when you
change the `.js` files.
- Visit http://app.lvh.me:3000/sessions/new
  - Sign in with `johndoe@example.com` as email and `featureflow` as the password

## Running the tests

- The tests are written with `rspec`
- Run `bundle exec rspec` to see if the tests are passing

## Running redis

Some features of the app like the member invite by email use redis. To install redis:

- `sudo apt update`
- `sudo apt install redis-server`
- `sudo systemctl restart redis.service`

After installing, run:

- `redis-server`, optional (you may need to)
- `bundle exec sidekiq` to start the sidekiq server
- Visit http://localhost:3000/sidekiq to view the processes

## Running the app with cache

We cache the app heavily for faster page transitions and to reduce `db`
bottleneck. Caching is enabled on production. To setup caching on your local
machine:

- Stop the rails server if any
- Run `rails dev:cache` to enable caching
- Run the rails server after that

To disable caching, run `rails dev:cache` and restart the rails server.
