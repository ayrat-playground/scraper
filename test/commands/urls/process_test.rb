# frozen_string_literal: true

require_relative '../../test_helper'

class Commands::Urls::ProcessTest < TestCase
  def test_scrapes_title_and_saves_it
    result = VCR.use_cassette('google') do
      Commands::Urls::Process.call('https://www.google.com')
    end

    assert result.status == 200
    assert result.title == 'Google'
    assert result.url == 'https://www.google.com'
  end

  def test_save_unresolvable_url_with_error
    result = VCR.use_cassette('can_not_resolve') do
      Commands::Urls::Process.call('https://g')
    end

    assert result.status == 0
    assert result.title == 'host can not be resolved'
    assert result.url == 'https://g'
  end
end
