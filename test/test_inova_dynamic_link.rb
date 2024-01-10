# frozen_string_literal: true

require "test_helper"

class TestInovaDynamicLink < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::InovaDynamicLink::VERSION
  end

  def test_empty_configuration_raises_error
    InovaDynamicLink.configuration = InovaDynamicLink::Configuration.new
    # assert empty configuration raises error
    begin
      InovaDynamicLink::Branch.new
      raise "Should not be here"
    rescue => e
      assert_equal e.class, ArgumentError
    end
  end

  def test_unknown_branch_config_attrs_raises_error
    InovaDynamicLink::BranchLinkConfiguration.new(foo: "bar")
    raise "Should not be here"
  rescue => e
    assert e.is_a?(InovaDynamicLink::UnknownAttributeError)
  end

  def test_branch_link_configuration
    branch_link_configuration = InovaDynamicLink::BranchLinkConfiguration.new(
      channel: "facebook",
      feature: "sharing",
      campaign: "content 123 launch",
      stage: "new user",
      tags: ["one", "two", "three"],
      link_alias: "myContentAlias",
      extra_data: {mydata: "something", foo: "bar"}
    )

    assert_equal branch_link_configuration.channel, "facebook"
    assert_equal branch_link_configuration.feature, "sharing"
    assert_equal branch_link_configuration.campaign, "content 123 launch"
    assert_equal branch_link_configuration.stage, "new user"
    assert_equal branch_link_configuration.tags, ["one", "two", "three"]
    assert_equal branch_link_configuration.link_alias, "myContentAlias"
    assert_equal branch_link_configuration.extra_data, {mydata: "something", foo: "bar"}
  end

  def test_branch_link_configuration_to_hash
    branch_link_configuration = InovaDynamicLink::BranchLinkConfiguration.new(
      channel: "facebook",
      feature: "sharing",
      campaign: "content 123 launch",
      stage: "new user",
      tags: ["one", "two", "three"],
      link_alias: "myContentAlias",
      extra_data: {mydata: "something", foo: "bar"}
    )
    branch_link_configuration_hash = branch_link_configuration.to_hash
    assert_equal branch_link_configuration_hash[:channel], "facebook"
    assert_equal branch_link_configuration_hash[:data].key?(:mydata), true
  end
end
