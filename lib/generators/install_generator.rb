require "rails/generators"

module InovaDynamicLink
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("templates", __dir__)

      def create_initializer_file
        copy_file "inova_dynamic_link_initializer.rb", "config/initializers/inova_dynamic_link.rb"
      end
    end
  end
end
