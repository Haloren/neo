require "bundler/setup"
require "neo/version"
require 'open-uri'
Bundler.require(:default, :development )
require_relative './neo/cli'
module Neo
  class Error < StandardError; end
  # Your code goes here...
end


#comment here