# frozen_string_literal: true

module Commands
  module Urls
    class Process
      def self.call(url)
        params = scrape(url)

        save(params)
      end

      private

      class << self
        def scrape(url)
          Commands::Urls::ScrapeUrl.call(url)
        end

        def save(params)
          Commands::Pages::Create.call(params)
        end
      end
    end
  end
end
