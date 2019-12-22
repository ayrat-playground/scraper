#### Scraper

### Description

Scraper is a simple web application that scrapes specified addresses for a title.

Used libraries:

- grape - web framework.
- active_record - ORM.
- minitest - test framework

### Setup:

- set your database params in `config/database.yml`
- run migrations with `(RAILS_ENV=development or test) bundle exec rake db:migrate`. Active Record uses `RAILS_ENV` to distinguish between environments.
- run tests with `bundle exec rake test`
- start application with `rackup config.ru`

### Usage

The application has a single endpoint that accepts a list of urls:

Curl example:
```
curl -H "Content-Type: application/json" -X POST -d '{"urls":["https://twitter.com/home", "https://github.com/ruby-grape/grape"]}'  http://localhost:9292/api/v1/pages/scrape
```

It returns scraped pages:
```
[{"status":302,"title":"","id":2,"url":"https://twitter.com/home","created_at":"2019-12-22T08:01:15.400Z","updated_at":"2019-12-22T08:01:15.400Z"},{"status":200,"title":"GitHub - ruby-grape/grape: An opinionated framework for creating REST-like APIs in Ruby.","id":9,"url":"https://github.com/ruby-grape/grape","created_at":"2019-12-22T08:18:44.114Z","updated_at":"2019-12-22T08:18:44.114Z"}]
```

Result contains:
- status - status code from http response. Unresolved hosts contain 0 in that field.
- title - scraped title. It can be empty of `title` tag is not found
- url - requested url
