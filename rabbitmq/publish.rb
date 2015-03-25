#!/usr/bin/env ruby
# encoding: utf-8

require "bunny"
require "forgery"
msg     = Forgery(:lorem_ipsum).words(100000)

conn = Bunny.new
conn.start

ch       = conn.create_channel
x        = ch.topic("topic_logs")

0.upto(100000) { x.publish(msg)  }
puts " [x] Sent :#{msg}"

conn.close
