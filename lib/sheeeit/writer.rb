module Sheeeit
  class Writer

    attr_reader :worksheet

    def initialize worksheet
      @worksheet = worksheet
    end

    def clear
      worksheet.reload
      num_cols = worksheet.num_cols
      ( worksheet.num_rows ).times do |i|
        ( num_cols ).times do |j|
          worksheet[i+1, j+1] = ""
        end
      end
      worksheet.save
    end

    def write data
      worksheet.reload
      clear if worksheet.num_rows > 0 || worksheet.num_cols > 0
      data.each.with_index do |row, i|
        row.each.with_index do |cell, j|
          worksheet[i+1, j+1] = cell
        end
      end
      worksheet.max_rows = data.count
      worksheet.max_cols = data.max_by { |a| a.count } .count
      worksheet.save
    end
  end
end
