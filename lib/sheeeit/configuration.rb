require 'yaml'

module Sheeeit
  class Configuration
    attr_accessor :google_auth
    attr_accessor :spreadsheet_key
    attr_accessor :worksheet_name
    attr_accessor :overview
    attr_accessor :overview_header

    SHEEEIT_YML_LOCATION = "config/sheeeit.yml"

    def initialize
      if File.exist? SHEEEIT_YML_LOCATION
        conf = YAML.load_file(SHEEEIT_YML_LOCATION)
        @google_auth     = indifferent_access conf, :google_auth
        @spreadsheet_key = indifferent_access conf, :spreadsheet_key
        @worksheet_name  = indifferent_access conf, :worksheet_name
        @overview        = indifferent_access conf, :overview
        @overview_header = indifferent_access conf, :overview_header
      end

      @google_auth     ||= "config/sheeeit.json"
      @overview        ||= false
      @overview_header ||= ["Sheet", "Last Updated At"]
    end

    private

      def indifferent_access hash, key_symbol
        hash[key_symbol] || hash[key_symbol.to_s]
      end
  end
end
