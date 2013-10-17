require 'set'
module Vagabond
  module Matchers
    module Nmap
      RSpec::Matchers.define :only_have_open_ports do |expected|
        match do |actual|
          (actual.open_port_numbers ^ Set.new(expected)).empty?
        end
      end
    end
  end
end
