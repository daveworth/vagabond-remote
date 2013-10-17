require 'set'
require 'tempfile'
require 'nmap/program'
require 'nmap/xml'

module Vagabond
  module Resources
    class Nmap < Resource
      attr_accessor :ip_address, :open_port_numbers
      def initialize(options={})
        @ip_address = Vagabond::Remote.ip_address

        @nmap_output_file = Tempfile.new("vagabond_remote_nmap")
        ::Nmap::Program.scan({}, {:out=>"/dev/null"}) do |nmap|
          nmap.service_scan = true
          nmap.targets = @ip_address
          nmap.xml     = @nmap_output_file.path
        end
      end

      def has_open_port?(port)
        case port
        when Numeric
          open_port_numbers.include? port
        when String
          open_service_names.include? port
        end
      end

      def has_remote_service?(service_name, options={})
        if options[:on_port]
          service_on_port = service_by_service_port(options[:on_port])
          service_on_port && service_on_port.service.product.downcase =~ /#{service_name.downcase}/
        else
          !service_by_service_product(service_name).nil?
        end
      end

      def has_remote_service_version?(service_name, version)
        has_remote_service?(service_name) && service_by_service_product(service_name).version =~ /#{version}/
      end

      def to_s
        "portscan(nmap)"
      end

      def open_port_numbers
        @open_port_numbers ||= Set.new(nmap_ports.map(&:number))
      end
      private

      def open_service_names
        @open_service_names ||= open_services.map(&:name)
      end

      def open_service_products
        @open_service_products ||= open_services.map(&:product).compact.map(&:downcase)
      end

      def service_by_service_port(port_number)
        nmap_ports.select { |port| port.number == port_number }.first
      end

      def service_by_service_product(product)
        our_product = product.dup.downcase
        open_services.select { |service| service.product && service.product.downcase =~ /#{our_product}/ }.first
      end

      def open_services
        @open_services ||= nmap_ports.map(&:service)
      end

      def nmap_ports
        @nmap_ports ||= ::Nmap::XML.new(@nmap_output_file.path).hosts.first.ports
      end
    end
  end
end
