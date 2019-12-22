# frozen_string_literal: true

module API
  module V1
    class Pages < Grape::API
      version 'v1', using: :path, vendor: 'scraper'

      resources :pages do
        desc 'Scrapes and saves multiple pages'

        params do
          requires :urls, type: Array[String]
        end
        post '/scrape' do
          Commands::Urls::ConcurrentProcess.call(params['urls'])
        end
      end
    end
  end
end
