# frozen_string_literal: true

# application.rb
require 'grape'
require 'otr-activerecord'

Dir["#{File.dirname(__FILE__)}/app/models/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/api/**/*.rb"].each { |f| require f }
Dir["#{File.dirname(__FILE__)}/app/commands/**/*.rb"].each { |f| require f }

OTR::ActiveRecord.configure_from_file! 'config/database.yml'

module API
  class Root < Grape::API
    format :json
    prefix :api

    mount V1::Pages
  end
end

Scraper = Rack::Builder.new do
  map '/' do
    run API::Root
  end
end
