# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  2.6.1

* run **docker-compose up** to run the program .

* open file **front-end/index.html** to see the front end

The database consist of two tables, exchangeable currencies and rate_histories.

Exchangeable currencies consists of two columns, from and to.

Meanwhile rate_histories has foreign key of exchangeable_currency, rate and date.

For each table there is a controller from which the routes hit the api. There is also Service package to break down the logic.

For unit test, RSpec is used under /spec package.
