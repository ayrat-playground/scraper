# frozen_string_literal: true

require_relative '../../test_helper'

class Commands::Urls::ConcurrentProcessTest < Minitest::Spec
  def test_processes_multiple_urls
    urls = ['https://yandex.ru/', 'https://duckduckgo.com/', 'https://github.com', 'https://www.hackerrank.com/', 'https://www.codewars.com/', 'https://exercism.io/']

    result = VCR.use_cassette('concurrent') do
      Commands::Urls::ConcurrentProcess.call(urls)
    end

    assert result.size == 6

    # DatabaseCleaner is not compatible with multithreading
    Page.destroy_all
  end
end
