# frozen_string_literal: true

require 'bundler/setup'
require 'rake/testtask'
load 'tasks/otr-activerecord.rake'

namespace :db do
  task :environment do
    require_relative 'application'
  end
end

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
end

namespace :g do
  desc 'Generate migration'
  task :migration do
    name = ARGV[1] || raise('Specify name: rake g:migration your_migration')
    timestamp = Time.now.strftime('%Y%m%d%H%M%S')
    path = File.expand_path("../db/migrate/#{timestamp}_#{name}.rb", __FILE__)
    migration_class = name.split('_').map(&:capitalize).join

    File.open(path, 'w') do |file|
      file.write <<~EOF
        class #{migration_class} < ActiveRecord::Migration[5.2]
          def self.up
          end
          def self.down
          end
        end
      EOF
    end

    puts "Migration #{path} created"
    abort # needed stop other tasks
  end
end
