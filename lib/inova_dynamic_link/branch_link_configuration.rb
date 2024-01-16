require "active_support/core_ext/object/blank"
require "active_support/core_ext/enumerable"

module InovaDynamicLink
  class BranchLinkConfiguration
    attr_accessor :channel, :feature, :stage, :campaign, :tags, :link_alias, :type, :duration, :fallback_url,
      :desktop_url, :ios_url, :android_url, :huawei_url, :windows_phone_url, :web_only, :desktop_web_only,
      :mobile_web_only, :after_click_url, :afterclick_desktop_url, :deeplink_path, :extra_data

    def initialize(**attributes)
      attributes = {
        tags: {},
        type: 0,
        duration: 7200,
        extra_data: {},
        **attributes
      }
      raise ArgumentError, "extra_data must be a hash" unless attributes[:extra_data].is_a?(Hash)
      attributes.each do |key, value|
        if respond_to?(:"#{key}=")
          send(:"#{key}=", value)
        else
          raise InovaDynamicLink::UnknownAttributeError.new(key)
        end
      end
    end

    def to_hash
      {
        channel: channel,
        feature: feature,
        stage: stage,
        campaign: campaign,
        tags: tags,
        alias: link_alias,
        type: type,
        duration: duration,
        data: {
          "$fallback_url": fallback_url,
          "$desktop_url": desktop_url,
          "$ios_url": ios_url,
          "$android_url": android_url,
          "$huawei_url": huawei_url,
          "$windows_phone_url": windows_phone_url,
          "$web_only": web_only,
          "$desktop_web_only": desktop_web_only,
          "$mobile_web_only": mobile_web_only,
          "$after_click_url": after_click_url,
          "$afterclick_desktop_url": afterclick_desktop_url,
          "$deeplink_path": deeplink_path,
          **extra_data
        }.compact_blank
      }.compact_blank
    end
  end
end
