require_relative  '../lib/heartbeat'

workers 1
# after_worker_boot do
  
# end

puts "PUMA.RB"
# ENV['PORT']=@config.options.user_options[:Port]
# puts "PORT  = #{ENV['PORT']}"
heartbeat = Heartbeat.new(ENV['RABBIT'])

@thr_stop = false 
@thr = Thread.new do
  loop do
    stop_requested = @thr_stop
    data = heartbeat.receive()
    break if stop_requested
  end
end