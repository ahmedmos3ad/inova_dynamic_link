module InovaDynamicLink
  class Configuration
    attr_accessor :branch_key, :branch_secret, :branch_access_token, :branch_app_id

    def validate!
      required_attributes = [:branch_key, :branch_secret, :branch_access_token, :branch_app_id]

      required_attributes.each do |attribute|
        value = send(attribute)
        raise ArgumentError, "#{attribute} is required in the configuration" if value.nil? || (value.respond_to?(:empty?) && value.empty?)
      end
    end
  end
end
