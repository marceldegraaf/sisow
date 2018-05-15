require 'dotenv/load'
require 'bundler/setup'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.start do
  add_filter 'vendor'
end

if ENV['BUILD_NUMBER'] && ENV['BUILD_ID']
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
end

require 'vcr_setup'

require 'sisow'

RSpec.configure do |config|
  config.mock_with(:rspec) { |c| c.syntax = :should }
  config.color = true
  config.tty = true
  config.formatter = :progress
  config.expect_with(:rspec) { |c| c.syntax = :should }

  config.before(:each) do
    Sisow.configure do |config|
      config.merchant_id  = ENV.fetch('MERCHANT_ID')
      config.merchant_key = ENV.fetch('MERCHANT_KEY')
      config.test_mode    = true
      config.debug_mode   = false
    end
  end
end
