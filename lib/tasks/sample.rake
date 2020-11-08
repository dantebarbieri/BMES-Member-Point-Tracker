# frozen_string_literal: true

namespace :sample do
  desc 'saying hi to cron'
  task test: :environment do
    puts Time.now
  end
end
