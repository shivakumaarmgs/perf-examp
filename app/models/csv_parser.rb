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
    prev = nil
    @csv_rows.each do |curr|
      Rails.logger.info "---- #{curr.inspect} #{prev.inspect}"
      old = prev["measurement"].to_f if prev
      new = curr["measurement"].to_f
      Rails.logger.info "out"
      if(old and new and old != 0)
        curr["performance"] = "#{((new-old)/old * 100).to_i} %"
        Rails.logger.info curr["performance"]
      end
      prev = curr
    end
  end
end
