require_relative 'env'
require_relative './lib/scrapers'

class App < Roda
  plugin :json # TODO: add oj serialization
  plugin :multi_route
  plugin :all_verbs
  plugin :not_found
  plugin :error_handler
  
  @@scrapers = Scrapers.new
 

  def initialize(env)
    super(env)
  end


  route do |r|
    r.root {
      p 'upc-lookup-gateway-roda/'
      {
        name: File.dirname(__FILE__),
      }
    }

    r.get 'rabbit' do
      require "bunny"
      connection = Bunny.new(hostname: 'localhost:5672')
      connection.start
      channel = connection.create_channel
      queue = channel.queue('heartbeat')
      loop do
        begin
          puts ' [*] Waiting for messages. To exit press CTRL+C'
          queue.subscribe(block: true) do |_delivery_info, _properties, body|
            puts " [x] Received #{body}"
          end
        rescue Interrupt => _
          connection.close
        end
      end

    end
    r.get "code",String do |code|
      p "upc-lookup-gateway-roda/code/#{code} of type string"
        res = @@scrapers.get_code(code)
      res
    end

    r.get "code",Integer do |code|
      p "upc-lookup-gateway-roda/code/#{code} of type integer"      
      res = @@scrapers.get_code(code)
      res
    end
 
  end
 
  not_found do
    {
      error: 404,
      error_message: "404 - Not Found"
    }
  end

  error do |err|
    case err
    # catch a proper error instead of nil...
    when nil
    # when CustomError
    #   "ERR" # like so
    else
      puts "-"*70
      puts "ERROR: loockup-gateway"
      pp err.backtrace
      pp err

  
      puts "-"*70
      {
        error: 500,
        error_message: "500 - Internal Server Error - check logs for details - error: '#{err.class} - #{err.message}'"
      }
    end
  end
end

# 