source "https://rubygems.org"

gem "hashie"
gem "inflecto"

gem "oj"
# gem "haml"
gem "roda"

# docker tmp server (nginx + passenger is ideal)
gem 'puma'

gem 'nokogiri' #parsing gem
gem 'httparty', '~> 0.13.7'
gem "bunny"


group :development do
  gem 'pry' #debugging tool
  gem 'rake'
end

group :test do
 gem 'guard-rspec', require: false
  # gem 'minite/st-matchers'
  # gem "minitest-matchers_vaccine"
  gem 'rspec-roda'
end