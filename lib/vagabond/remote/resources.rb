$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'resources'))

module Vagabond
  module Resources
    class Resource
    end
  end
end

require 'vagabond/remote/resources/nmap'
require 'vagabond/remote/resources/webapp'
