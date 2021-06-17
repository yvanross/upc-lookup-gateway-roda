# https://dylanwolff.com/posts/blocking-abusive-requests-to-your-ruby-app-with-rack-attack/
require_relative '../app.rb'
require 'spec_helper'
RSpec.describe App, roda: :app do
    describe '/' do
      before { get '/' }
  
      it { is_expected.to be_successful }
      its(:body) { is_expected.to eq  "{\"name\":\"upc-lookup-gateway-roda\"}"}
    end

    describe 'heartbeat' do
      before { get '/heartbeat/localhost/5555' }
      # it { is_expected.to be_successful }
      its(:body) { is_expected.to eq  "{\"status\":\"ok\"}" }
    end

    
end    