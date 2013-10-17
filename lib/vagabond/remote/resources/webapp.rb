require 'capybara'
require 'capybara-webkit'
require 'uri'

module Vagabond
  module Resources
    class Webapp < Resource
      attr_accessor :name, :url
      def initialize(name, options = {})
        if name =~ URI::regexp
          @name = @url = name
        else
          @name = name
          @url = options[:url]
        end
      end
    end
  end
end
