require 'test_helper'

class SheeeitTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Sheeeit::VERSION
  end

  #
  # "validation"
  #

  def test_request_worksheet_will_raise_error_unless_configured
    assert_raises Sheeeit::NotConfiguredError do
      Sheeeit.request_worksheet "overview"
    end
  end

  def test_write_spreadsheet_only_accepts_an_array_of_arrays
    assert_raises(Sheeeit::InvalidDataError) { Sheeeit.write_spreadsheet [] }
    assert_raises(Sheeeit::InvalidDataError) { Sheeeit.write_spreadsheet [1,2,3] }
    assert_raises(Sheeeit::InvalidDataError) { Sheeeit.write_spreadsheet [[1,2,3], 4, 5, 6] }
  end


  #
  # actually doing work
  #

  def test_write_spreadsheet_should_pass_data_to_a_writer
    worksheet = stub_everything("worksheet")
    writer = mock

    Sheeeit.expects(:request_worksheet).returns(worksheet)
    Sheeeit::Writer.expects(:new).returns(writer)
    writer.expects(:write).with(data).once

    Sheeeit.write_spreadsheet(data)
  end

  def test_write_overview_should_pass_data_to_a_writer
    Sheeeit.configure do |config|
      config.overview = true
      config.overview_header = ["Something Something", "Header"]
      config.worksheet_name  = "testing_overview"
    end

    worksheet = stub_everything("worksheet")
    writer = mock

    Sheeeit.expects(:request_worksheet).with("overview").returns(worksheet)
    worksheet.expects(:rows).returns([])
    Sheeeit::Writer.expects(:new).returns(writer)
    writer.expects(:write).with([["Something Something", "Header"], ["testing_overview", Date.today.to_s]])

    Sheeeit.write_overview
  end

  private

    def data
      [
        ["h1", "h2", "h3"],
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9]
      ]
    end
end
