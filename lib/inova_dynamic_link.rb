# frozen_string_literal: true

require_relative "inova_dynamic_link/version"
require_relative "inova_dynamic_link/configuration"
require_relative "inova_dynamic_link/branch"
require_relative "inova_dynamic_link/branch_link_configuration"
require_relative "inova_dynamic_link/unknown_attribute_error"

module InovaDynamicLink
  class Error < StandardError; end
  # Your code goes here...

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end
end
