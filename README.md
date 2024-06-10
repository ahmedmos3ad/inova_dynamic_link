# InovaDynamicLink

InovaDynamicLink is a Ruby gem designed to streamline interactions with the Branch Dynamic Links service for Ruby applications. This gem provides a convenient interface for creating dynamic links using the [Branch](https://branch.io/) service.

## Installation

To integrate InovaDynamicLink into your project, add the following line to your application's Gemfile:

```ruby
gem 'inova_dynamic_link', '~> 0.2.2'
```

Or, install the gem directly using the following command:

```bash
gem install inova_dynamic_link -v 0.2.2
```

## Requirements

- Ruby >= 3.1.2
- Rails >= 6.1

## Usage

```bash
rails generate inova_dynamic_link:install
```

This will generate a configuration file at config/initializers/inova_dynamic_link.rb. Open the file and set your Branch credentials:

```ruby
InovaDynamicLink.configure do |config|
  # Set your Branch configuration options here
  config.branch_key = "YOUR_BRANCH_KEY"
  config.branch_secret = "YOUR_BRANCH_SECRET"
  config.branch_access_token = "YOUR_BRANCH_ACCESS_TOKEN"
  config.branch_app_id = "YOUR_BRANCH_APP_ID"
end
```

Replace "YOUR_BRANCH_KEY", "YOUR_BRANCH_SECRET", "YOUR_BRANCH_ACCESS_TOKEN", and "YOUR_BRANCH_APP_ID" with your actual Branch credentials.

### Creating a Dynamic Link

here is an example of how to create a dynamic link:

```ruby
link_configuration = InovaDynamicLink::BranchLinkConfiguration.new(
  channel: 'social',
  feature: 'share',
  campaign: 'spring_sale',
  extra_data: { product_id: 123 }
)
dynamic_link =  InovaDynamicLink::Branch.new.create(link_configuration)
puts "Dynamic Link: #{dynamic_link}"
```

Check out the [Branch documentation](https://help.branch.io/developers-hub/reference/createdeeplinkurl) for more information on the available configuration options.
Check out the [BranchLinkConfiguration class](https://github.com/ahmedmos3ad/inova_dynamic_link/blob/master/lib/inova_dynamic_link/branch_link_configuration.rb) for more information on the available configuration options.

### Bulk Link Creation

You can create multiple links at once using the following method:

```ruby
link_configurations = [
  InovaDynamicLink::BranchLinkConfiguration.new(...),
  InovaDynamicLink::BranchLinkConfiguration.new(...)
  # Add more configurations as needed
]
dynamic_links = InovaDynamicLink::Branch.new.bulk_create(link_configurations)
puts "Dynamic Links: #{dynamic_links}"
```

### Retrieving a Dynamic Link

You can retrieve a dynamic link using the following method:

```ruby
url_to_check = "https://your.dynamic.link/url"
response = InovaDynamicLink::Branch.new.get(url_to_check)
puts "Dynamic Link Information: #{response}"
```

### Deleting a Dynamic Link

You can delete a dynamic link using the following method:

```ruby
url_to_delete = "<https://your.dynamic.link/to/delete>"
result = InovaDynamicLink::Branch.new.delete(url_to_delete)
puts "Delete Dynamic Link Result: #{result}"
```

### Updating a Dynamic Link

Updating a dynamic link is currently not supported by this gem, it will be added in a future release.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/ahmedmos3ad/inova_dynamic_link>. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ahmedmos3ad/inova_dynamic_link/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the InovaDynamicLink project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[ahmedmos3ad]/inova_dynamic_link/blob/master/CODE_OF_CONDUCT.md).
