#!/bin/bash -l

export RAILS_ROOT=`pwd`
export RAILS_ENV=development

god -D -c script/god/run_angels.god.rb -P tmp/pids/god.pid -l log/god.log 
