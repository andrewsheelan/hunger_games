RAILS_ROOT                      = ENV['RAILS_ROOT']
RAILS_ENV                       = ENV['RAILS_ENV']
God.pid_file_directory          = RAILS_ROOT + "/tmp/pids"


if nil
  God.watch do |w|
    w.name          = "redis"
    w.group         = "redis-server"
    w.dir           = RAILS_ROOT
    w.start         = "redis-server /usr/local/etc/redis-winuru.conf"
    w.start_grace   = 20.seconds
    w.restart_grace = 20.seconds
    w.stop          = "kill -s QUIT $(cat #{w.pid_file})"
    w.env           = { 'RAILS_ROOT' => RAILS_ROOT, 'RAILS_ENV' => RAILS_ENV }

    w.behavior(:clean_pid_file)   
    
    w.keepalive

    w.interval = 30.seconds

    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
        c.notify  = '#ops'
      end
      on.condition(:cpu_usage) do |c|
        c.times   = [2, 5]
        c.above   = 50.percent
        c.notify  = '#ops'
      end
      on.condition(:memory_usage) do |c|
        c.times   = [2, 5]
        c.above   = 512.megabytes
        c.notify  = '#ops'
      end
      on.condition(:flapping) do |c|
        c.to_state  = [:start, :restart]
        c.notify    = '#ops'
        c.times     = 5
        c.within    = 5.minute
      end
    end

  end
end

if nil
  God.watch do |w|
    w.name          = "sidekiq"
    w.group         = "sidekiq-servers"
    w.dir           = RAILS_ROOT
    w.start         = "bundle exec sidekiq -v -e #{RAILS_ENV} -C config/sidekiq_config.yml"
    w.start_grace   = 20.seconds
    w.restart_grace = 20.seconds
    w.stop          = "kill -s QUIT $(cat #{w.pid_file})"
    w.env           = { 'RAILS_ROOT' => RAILS_ROOT, 'RAILS_ENV' => RAILS_ENV }

    w.behavior(:clean_pid_file)   
    
    w.keepalive

    w.interval = 30.seconds

    w.transition(:up, :start) do |on|
      on.condition(:process_running) do |c|
        c.running = false
        c.notify  = '#ops'
      end
      on.condition(:cpu_usage) do |c|
        c.times   = [2, 5]
        c.above   = 50.percent
        c.notify  = '#ops'
      end
      on.condition(:memory_usage) do |c|
        c.times   = [2, 5]
        c.above   = 512.megabytes
        c.notify  = '#ops'
      end
      on.condition(:flapping) do |c|
        c.to_state  = [:start, :restart]
        c.notify    = '#ops'
        c.times     = 5
        c.within    = 5.minute
      end
    end

  end
end

God.watch do |w|
  w.name          = "elasticsearch"
  w.group         = "elasticsearch-servers"
  w.dir           = RAILS_ROOT
  w.start         = "elasticsearch"
  w.start_grace   = 20.seconds
  w.restart_grace = 20.seconds
  #w.stop          = "kill -s QUIT $(cat #{w.pid_file})"
  w.stop          = "curl -XPOST 'http://127.0.0.1:9200/_shutdown'"
  w.env           = { 'RAILS_ROOT' => RAILS_ROOT, 'RAILS_ENV' => RAILS_ENV }

  w.behavior(:clean_pid_file)   
  
  w.keepalive

  w.interval = 30.seconds

  w.transition(:up, :start) do |on|
    on.condition(:process_running) do |c|
      c.running = false
      c.notify  = '#ops'
    end
    on.condition(:cpu_usage) do |c|
      c.times   = [2, 5]
      c.above   = 50.percent
      c.notify  = '#ops'
    end
    on.condition(:memory_usage) do |c|
      c.times   = [2, 5]
      c.above   = 512.megabytes
      c.notify  = '#ops'
    end
    on.condition(:flapping) do |c|
      c.to_state  = [:start, :restart]
      c.notify    = '#ops'
      c.times     = 5
      c.within    = 5.minute
    end
  end

end

God.watch do |w|
  w.name          = "rabbitmq"
  w.group         = "rabbitmq-servers"
  w.dir           = RAILS_ROOT
  w.start         = "rabbitmq-server"
  w.start_grace   = 20.seconds
  w.restart_grace = 20.seconds
  w.stop          = "kill -s QUIT $(cat #{w.pid_file})"
  w.env           = { 'RAILS_ROOT' => RAILS_ROOT, 'RAILS_ENV' => RAILS_ENV }

  w.behavior(:clean_pid_file)   
  
  w.keepalive

  w.interval = 30.seconds

  w.transition(:up, :start) do |on|
    on.condition(:process_running) do |c|
      c.running = false
      c.notify  = '#ops'
    end
    on.condition(:cpu_usage) do |c|
      c.times   = [2, 5]
      c.above   = 50.percent
      c.notify  = '#ops'
    end
    on.condition(:memory_usage) do |c|
      c.times   = [2, 5]
      c.above   = 512.megabytes
      c.notify  = '#ops'
    end
    on.condition(:flapping) do |c|
      c.to_state  = [:start, :restart]
      c.notify    = '#ops'
      c.times     = 5
      c.within    = 5.minute
    end
  end

end
