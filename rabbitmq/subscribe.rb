#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"

conn = Bunny.new
conn.start

ch  = conn.create_channel
x   = ch.topic("topic_logs")
q   = ch.queue("", :exclusive => true)
q.bind(x)
puts " [*] Waiting for logs. To exit press CTRL+C"

begin
  q.subscribe(:block => true) do |delivery_info, properties, body|
    puts " [x] #{delivery_info.routing_key}:#{body}"
  end
rescue Interrupt => _
  ch.close
  conn.close
end
