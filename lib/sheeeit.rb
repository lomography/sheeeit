require "google/api_client"
require "google_drive"

require "sheeeit/configuration"
require "sheeeit/exceptions"
require "sheeeit/writer"
require "sheeeit/version"


module Sheeeit

  class << self

    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end

    def request_worksheet name
      if configuration.spreadsheet_key.nil? || configuration.worksheet_name.nil? || configuration.google_auth.nil?
        raise NotConfiguredError.new("must set worksheet_title, spreadsheet_key and google_auth ")
      end


      session     = GoogleDrive.saved_session(configuration.google_auth)
      spreadsheet = session.spreadsheet_by_key(configuration.spreadsheet_key)
      worksheet   = spreadsheet.worksheet_by_title(name)
      worksheet ||= spreadsheet.add_worksheet(name)
    end

    def write_spreadsheet data
     unless data.is_a?(Array) && data.any? && data.all? { |d| d.is_a? Array }
        raise InvalidDataError.new("data must be given as array of arrays")
      end

      worksheet = request_worksheet configuration.worksheet_name
      writer = Writer.new(worksheet)
      writer.write data
      write_overview if configuration.overview
    end

    def write_overview
      worksheet = request_worksheet "overview"
      rows = worksheet.rows.map { |r| r.dup } # unfreeze rows
      rows = update_overview_rows(rows)
      writer = Writer.new(worksheet)
      writer.write rows
    end

    private

      def update_overview_rows rows
        rows.reject! { |r| r[0] == configuration.overview_header[0] && r[1] == configuration.overview_header[1] }
        rows.reject! { |r| r[0] == configuration.worksheet_name }
        rows.push [ configuration.worksheet_name, Date.today.to_s ]
        rows.sort_by! { |r| r.first }
        rows.unshift configuration.overview_header
      end
  end
end
