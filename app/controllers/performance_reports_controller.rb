require 'csv'

class PerformanceReportsController < ApplicationController

  def index
    @csv_files = Dir.glob "#{Rails.root}/tmp/performance/*_wall_time.csv"
    @file_name = params[:file_name]
    if @file_name
      @csv_rows = []
      @headers = CSV.open(@file_name).first
      CSV.foreach(params[:file_name], headers: true) do |row|
        @csv_rows << row
      end
    end
  end

end
