require "bundler/setup"
require "neo/version"
require 'open-uri'
require 'nokogiri'
Bundler.require(:default, :development)

require_relative './neo/cli'
require_relative './neo/scraper'
require_relative './neo/neos'


#comment here