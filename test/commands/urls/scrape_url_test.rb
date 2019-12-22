# frozen_string_literal: true

require_relative '../../test_helper'

class Commands::Urls::ScrapeUrlTest < TestCase
  def test_parses_a_title
    result = VCR.use_cassette('google') do
      Commands::Urls::ScrapeUrl.call('https://www.google.com')
    end

    assert result == {
      url: 'https://www.google.com',
      status: 200,
      title: 'Google'
    }
  end

  def test_can_not_resolve_a_host
    result = VCR.use_cassette('can_not_resolve') do
      Commands::Urls::ScrapeUrl.call('https://g')
    end

    assert result == {
      url: 'https://g',
      error: 'host can not be resolved'
    }
  end

  def test_site_with_redirect
    result = VCR.use_cassette('redirect') do
      Commands::Urls::ScrapeUrl.call('http://gaerten-und-parke.de')
    end

    assert result == { url: 'http://gaerten-und-parke.de', status: 301, title: '301 Moved Permanently' }
  end

  def test_returns_empty_title_if_title_is_empty
    result = VCR.use_cassette('no title') do
      Commands::Urls::ScrapeUrl.call('https://twitter.com/home')
    end

    assert result == { url: 'https://twitter.com/home', status: 302, title: '' }
  end
end
