# require 'uri'
# require 'net/http'
# docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management

require 'date'
require 'bunny'

class Heartbeat


    def initialize(rabbit_address)
        @rabbit_address = rabbit_address
        raise StandardError.new "RABBIT environement variable not defined" if rabbit_address.nil?
       
    end

    def connect
        begin
            connection = Bunny.new(ENV['RABBIT'])      
            connection.start
            channel = connection.create_channel
            @channel = connection.create_channel
            @queue = channel.queue('heartbeat')
        rescue => error
            p error.backtrace
            p "#{@rabbit_address} is not running"
        end
    end

    def receive
        begin
            puts ' [*] Waiting for messages. To exit press CTRL+C'

            @queue.subscribe(block: true) do |_delivery_info, _properties, body|
              puts " [x] Received #{body}"
            end
        rescue Interrupt => _
            connection.close
        end    
    end


  

end

