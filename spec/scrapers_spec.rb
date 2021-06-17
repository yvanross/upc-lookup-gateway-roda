require_relative '../lib/scrapers'
require 'json'

RSpec.describe  'Scrapers' do
    before(:each) do
        @scrapers = Scrapers.new
        @scrapers.add("localhost:5405")
        @scrapers.add("localhost:5405")
        @scrapers.add("localhost:5406")
        @scrapers.add("localhost:5406")
        @scrapers.add("localhost:5407") 
        @scrapers.add("localhost:5408")
        @scrapers.add("localhost:5409")
    end
    it "add and get scrapers" do
        
        previous = [5405,5406,5405,5408,5409]
        res=[]
        0.upto(5) do 
           res =  @scrapers.all()
            expect(res).not_to eq(previous)
            previous = res
        end
        expect(res).to include "localhost:5405"
        expect(res).to include "localhost:5406"
        expect(res).to include "localhost:5407"
        expect(res).to include "localhost:5408"
    end

    it "get code" do
        @scrapers = Scrapers.new
        @scrapers.add("localhost:6307")
        result = @scrapers.get_code("065633128507")
        expect(result).to include "{\"code\":\"065633128507\""
        expect(result).to include "\"valid\":true,\""
        expect(result).to include "lange du randonneur - Val Natur"
        expect(result).to include "facts.org/images/products/006/563/312/8507/front_fr.12.200.jpg\""
        expect(result).to include "\"provider\":\"openfoodfacts.rb\"}" 
    end 


end 