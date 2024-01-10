module InovaDynamicLink
  class UnknownAttributeError < StandardError
    def initialize(attribute)
      super("Unknown attribute: #{attribute}")
    end
  end
end
