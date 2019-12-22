# frozen_string_literal: true

module Commands
  module Urls
    class ConcurrentProcess
      MAX_NUMBER_OF_THREADS = 16

      def self.call(urls)
        urls.map do |url|
          maybe_new_thread do
            Commands::Urls::Process.call(url)
          end
        end.map(&:value)
      end

      private

      def self.maybe_new_thread
        if Thread.list.size < MAX_NUMBER_OF_THREADS
          Thread.new { yield }
        else
          result = yield

          result_struct = Struct.new(:value)
          result_struct.new(result)
        end
      end
    end
  end
end
