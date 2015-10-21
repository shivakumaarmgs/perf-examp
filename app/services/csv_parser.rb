class CSVParser

  attr_reader :headers, :csv_rows

  def initialize(file_path)
    @file_name = file_path
  end

  def parse
    @headers = CSV.open(@file_name).first
    @csv_rows = []
    CSV.foreach(@file_name, headers: true) do |row|
      @csv_rows << row
    end
    @csv_rows.each do |curr, prev|
      old = prev["measurement"].to_f
      new = curr["measurement"].to_f
      if(old and new and old != 0)
        curr["performance"] = (new-old)/old * 100
      end
    end
  end
end
