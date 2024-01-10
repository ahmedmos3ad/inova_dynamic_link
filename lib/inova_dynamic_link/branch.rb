module InovaDynamicLink
  class Branch
    require "uri"
    require "httparty"
    require "json"
    require "active_support/core_ext/object/blank"
    require "active_support/core_ext/enumerable"

    DEFAULT_HEADERS = {"Content-Type": "application/json"}
    BRANCH_URI = "https://api2.branch.io/v1/url"

    attr_reader :branch_key, :branch_secret, :branch_access_token, :branch_app_id

    def initialize
      InovaDynamicLink.configuration.validate!
      @branch_key = InovaDynamicLink.configuration.branch_key
      @branch_secret = InovaDynamicLink.configuration.branch_secret
      @branch_access_token = InovaDynamicLink.configuration.branch_access_token
      @branch_app_id = InovaDynamicLink.configuration.branch_app_id
    end

    # https://help.branch.io/developers-hub/reference/createdeeplinkurl

    # accepts InovaDynamicLink::BranchLinkConfiguration object as an argument
    def create(branch_link_configuration)
      raise ArgumentError, "argument must be a InovaDynamicLink::BranchLinkConfiguration" unless branch_link_configuration.is_a?(InovaDynamicLink::BranchLinkConfiguration)
      body = {
        branch_key: @branch_key,
      }.merge(branch_link_configuration.to_hash)

      response = HTTParty.post(BRANCH_URI, headers: DEFAULT_HEADERS, body: body.to_json)
      json_resp = JSON.parse(response.body)
      raise HTTParty::ResponseError, json_resp["error"]["message"] if json_resp["error"].present?
      raise HTTParty::ResponseError, json_resp unless response.code == 200
      json_resp["url"]
    end
    # branch_link_configuration_array is an array of InovaDynamicLink::BranchLinkConfiguration
    def bulk_create(branch_link_configuration_array)
      branch_link_configuration_array = [branch_link_configuration_array].compact_blank unless branch_link_configuration_array.is_a?(Array)
      raise ArgumentError, "argument hash array cannot be empty" if branch_link_configuration_array.empty?
      unless branch_link_configuration_array.all? { |o| o.is_a?(InovaDynamicLink::BranchLinkConfiguration) }
        raise ArgumentError, "argument must be an array of InovaDynamicLink::BranchLinkConfiguration"
      end
      config_hash_array = branch_link_configuration_array.map{|config| config.to_hash}
      response = HTTParty.post(BRANCH_URI + "/bulk/" + @branch_key, headers: DEFAULT_HEADERS, body: config_hash_array.to_json)
      raise HTTParty::ResponseError, response unless response.code == 200
      JSON.parse(response.body).map{|resp| resp["url"]}
    end

    def get(url)
      validate_url(url)
      HTTParty.get(BRANCH_URI + "?url=#{url}&branch_key=#{@branch_key}", headers: DEFAULT_HEADERS)
      raise HTTParty::ResponseError, response["error"]["message"] if response["error"].present?
      raise HTTParty::ResponseError, "404 Not Found" unless response.code == 200
      JSON.parse(response.body)
    end

    def delete(url)
      validate_url(url)
      response = HTTParty.delete(BRANCH_URI + "?url=#{url}&app_id=#{@branch_app_id}", headers: DEFAULT_HEADERS.merge({"Access-Token": @branch_access_token}))
      raise HTTParty::ResponseError, "Error deleting dynamic link" unless response.code == 200
      json_resp = JSON.parse(response.body)
      raise HTTParty::ResponseError, json_resp["error"]["message"] if json_resp["error"].present?
      json_resp
    end

    private

    def validate_url(url)
      uri = URI.parse(url)
      raise URI::InvalidURIError, "Invalid URL" unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    end
  end
end
