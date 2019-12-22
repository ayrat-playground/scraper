# frozen_string_literal: true

# config.ru
require File.expand_path('application', __dir__)
require 'otr-activerecord'

use OTR::ActiveRecord::ConnectionManagement

run Scraper
