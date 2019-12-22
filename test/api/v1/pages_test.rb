# frozen_string_literal: true

require_relative '../../test_helper.rb'
require 'rack/test'

class API::V1::PagesTest < TestCase
  include Rack::Test::Methods

  def app
    API::Root
  end

  def test_post_scrape_creates_pages
    VCR.use_cassette('api_success') do
      post '/api/v1/pages/scrape', urls: ['https://www.facebook.com/', 'https://vk.com/']
    end

    assert last_response.status == 201

    result = JSON.parse(last_response.body)
    assert result.size == 2
  end

  def test_fails_to_create_pages_with_wrong_params
    post '/api/v1/pages/scrape', foo: 'bar'

    assert last_response.status == 400
  end
end
