# frozen_string_literal: true

require_relative "lib/inova_dynamic_link/version"

Gem::Specification.new do |spec|
  spec.name = "inova_dynamic_link"
  spec.version = InovaDynamicLink::VERSION
  spec.authors = ["Ahmed Mos`ad"]
  spec.email = ["ahmed.mosad@inovaeg.com"]

  spec.summary = "Ruby gem to manage dynamic links using branch.io."
  spec.homepage = "https://github.com/ahmedmos3ad/inova_dynamic_link"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.2"
  spec.add_dependency "rails", ">= 6.1"
  spec.add_dependency "httparty", "~> 0.21.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ahmedmos3ad/inova_dynamic_link"
  spec.metadata["changelog_uri"] = "https://github.com/ahmedmos3ad/inova_dynamic_link/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
