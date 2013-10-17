$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'vagabond'))
require 'vagrant'
require 'rspec'
require 'vagabond/remote/matchers'
require 'vagabond/remote/resources'

module Vagabond
  include Vagabond::Matchers
  include Vagabond::Resources

  def ip_address
    # gah... there be dragons!  I just found a way in Irb but there _must_ be
    # a better way using the Gem...
    Vagrant::Environment.new.vms.first.last.config.vm.networks.select { |type, info| type == :hostonly }.first.last.first
  end

  def default_url(protocol = "http")
    "#{protocol}://#{ip_address}"
  end
end
