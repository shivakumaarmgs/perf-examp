require 'csv'

class PerformanceReportsController < ApplicationController

  def index
    @csv_files = Dir.glob "#{Rails.root}/tmp/performance/*_wall_time.csv"
    @file_name = params[:file_name]
    if @file_name
      @csv_file = CSVParser.new(@file_name)
      @csv_file.parse
    end
  end

end
