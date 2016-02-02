require 'test_helper'

module Sheeeit
  class WriterTest < Minitest::Test

    #
    # clear
    #

    def test_clear_should_update_every_field_of_worksheet
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(6)
      worksheet.expects(:num_cols).returns(3)
      worksheet.expects(:[]=).times(18)

      writer = Writer.new(worksheet)
      writer.clear
    end

    def test_clear_should_reload_and_save
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(2)
      worksheet.expects(:num_cols).returns(2)
      worksheet.expects(:reload).once
      worksheet.expects(:save).once

      writer = Writer.new(worksheet)
      writer.clear
    end

    #
    # write
    #

    def test_write_should_clear_if_worksheet_not_empty
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(2).at_most_once
      worksheet.expects(:num_cols).returns(2).at_most_once

      writer = Writer.new(worksheet)
      writer.expects(:clear).once
      writer.write data
    end

    def test_writer_should_not_clear_if_worksheet_empty
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(0).at_most_once
      worksheet.expects(:num_cols).returns(0).at_most_once

      writer = Writer.new(worksheet)
      writer.expects(:clear).never
      writer.write data
    end

    def test_write_should_update_every_cell_given_in_data
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(0)
      worksheet.expects(:num_cols).returns(0)
      worksheet.expects(:[]=).times(12)

      writer = Writer.new(worksheet)
      writer.write data
    end

    def test_write_should_set_max_cols_and_rows
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(0)
      worksheet.expects(:num_cols).returns(0)
      worksheet.expects(:max_rows=).with(4).once
      worksheet.expects(:max_cols=).with(3).once

      writer = Writer.new(worksheet)
      writer.write data
    end

    def test_write_reload_and_save
      worksheet = stub_everything("worksheet")
      worksheet.expects(:num_rows).returns(0)
      worksheet.expects(:num_cols).returns(0)
      worksheet.expects(:reload).once
      worksheet.expects(:save).once

      writer = Writer.new(worksheet)
      writer.write data
    end

    private

      def data
        [
          ["h1", "h2", "h3" ],
          ["1", "2", "3" ],
          ["4", "5", "6" ],
          ["7", "8", "9" ]
        ]
      end
  end
end
