#activejob_with_sneakers.rb

require 'bundler/setup'
require 'active_job'
require 'sneakers'

opts = {
  :amqp => 'CLOUDAMQP_URL',
  :vhost => 'vhost',
  :exchange => 'sneakers',
  :exchange_type => :direct
}

Sneakers.configure(opts)
ActiveJob::Base.queue_adapter = :sneakers

class MyBackgroundJob < ActiveJob::Base
  queue_as :job_queue

  def perform()
    puts 'Perform a job'
  end
end

# Enqueue a job to be performed as soon the queueing system is free.
MyBackgroundJob.perform_later()
