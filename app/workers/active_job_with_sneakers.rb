#activejob_with_sneakers.rb

require 'bundler/setup'
require 'active_job'
require 'sneakers'

opts = {
  :amqp => 'amqp://127.0.0.1:5672',
  :exchange => 'sneakers',
  :exchange_type => :direct
}

Sneakers.configure(opts)
ActiveJob::Base.queue_adapter = :sneakers

class ActiveJobWithSneakers < ActiveJob::Base
  queue_as :job_queue

  def run()
    puts 'Perform a job'
  end
end

# Enqueue a job to be performed as soon the queueing system is free.
# ActiveJobWithSneakers.perform_later()
