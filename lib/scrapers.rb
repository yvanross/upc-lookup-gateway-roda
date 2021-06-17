require 'uri'
require 'net/http'

class Scrapers

    def initialize()
        @scrapers = []
    end

    def add(scraper_port)
        @scrapers.push scraper_port
        @scrapers.uniq!
    end
    
    def all()
        @scrapers.shuffle
    end

    def get_code(code)
        p "scraper get_code: #{code}"
        all().each do |scraper_url|
            begin
                uri = URI("http://#{scraper_url}/#{code}")
                p "upc-lookup-gateway-roda call: #{uri} "
           
                res = Net::HTTP.get_response(uri)
                pp res
                if (res.code == "200" && (res.body.include? "valid\":true"))
                    p "received responses from scraper"
                    return res.body
                end
            rescue => error
                p "upc-lookup-gateway-roda: #{error}"
            end
        end
        return {valid: false, message: "fail to found #{code} code in #{all().count} providers"}
    end
    
end