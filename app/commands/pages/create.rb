# frozen_string_literal: true

module Commands
  module Pages
    class Create
      def self.call(params)
        params = handle_error(params)

        Page.where(url: params[:url]).first_or_initialize.tap do |page|
          page.status = params[:status]
          page.title = params[:title]

          page.save
        end
      end

      private

      def self.handle_error(params)
        if params[:error]
          {
            title: params[:error],
            status: 0,
            url: params[:url]
          }
        else
          params
        end
      end
    end
  end
end
