# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'active_record'
require 'active_record/fixtures'
require 'database_cleaner'
require 'vcr'
require_relative '../application'

ActiveRecord::Base.logger = nil
ActiveRecord::Migration.verbose = true

DatabaseCleaner.strategy = :transaction

VCR.configure do |config|
  config.cassette_library_dir = 'fixtures/vcr_cassettes'
  config.hook_into :faraday
end

Dir.glob('./test/support/*.rb').each { |file| require file }
