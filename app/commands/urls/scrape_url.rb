# frozen_string_literal: true

require 'faraday'
require 'nokogiri'

module Commands
  module Urls
    class ScrapeUrl
      ERROR_MESSAGE = 'host can not be resolved'

      def self.call(link)
        result = fetch_page(link)

        if result[:error]
          result
        else
          result[:title] = fetch_title(result[:body])
          result.delete(:body)

          result
        end
      end

      private

      class << self
        def fetch_page(url)
          response = Faraday.get(url)

          {
            url: url,
            status: response.status,
            body: response.body
          }
        rescue Faraday::ConnectionFailed
          {
            url: url,
            error: ERROR_MESSAGE
          }
        end

        def fetch_title(html)
          document = Nokogiri::HTML(html)

          element = document.at('title')

          if element
            element.text
          else
            ''
          end
        end
      end
    end
  end
end
