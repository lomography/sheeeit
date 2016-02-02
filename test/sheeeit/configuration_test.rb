require 'test_helper'

module Sheeeit
  class ConfigurationTest < Minitest::Test

    #
    # autoload
    #

    def test_should_take_values_from_config_sheeeit_yml
      mock_sheeeit_yml spreadsheet_key: "abc123", worksheet_name: "sheeeit"

      configuration = Configuration.new
      assert_equal "abc123", configuration.spreadsheet_key
      assert_equal "sheeeit", configuration.worksheet_name
    end

    def test_sheeeit_yml_accepts_string_keys_as_well
      mock_sheeeit_yml "spreadsheet_key" => "abc123", "worksheet_name" => "sheeeit"
      configuration = Configuration.new
      assert_equal "abc123", configuration.spreadsheet_key
      assert_equal "sheeeit", configuration.worksheet_name
    end

    #
    # default values
    #

    def test_default_values_are_correct
      mock_missing_sheeeit_yml

      configuration = Configuration.new
      assert_equal "config/sheeeit.json", configuration.google_auth
      assert_nil configuration.spreadsheet_key
      assert_nil configuration.worksheet_name
      refute configuration.overview
      assert_equal ["Sheet", "Last Updated At"], configuration.overview_header
    end

  private

    def mock_missing_sheeeit_yml
      File.expects(:exist?).with("config/sheeeit.yml").returns(false)
    end

    def mock_sheeeit_yml hash
      File.expects(:exist?).with("config/sheeeit.yml").returns(true)
      YAML.expects(:load_file).with("config/sheeeit.yml").returns(hash)
    end
  end
end
