require 'test_helper'
require 'csv'

class ValidateBenchmarkTest < ActionDispatch::IntegrationTest

  test "validate time benchmarks are good" do
    csv_files = Dir.glob "#{Rails.root}/tmp/performance/*_wall_time.csv"
    csv_files.each do |csv_file|
      old, new = CSV.open(csv_file).to_a[-2,2].map(&:first).map(&:to_f)
      # calculate % increase in time if greater than 10 assert false
      unless(old == 0 and new == 0)
        a = (new-old)/old * 100
        if(a> 10)
        assert false, "Validating #{csv_file.split('#').last}. Last request took around #{new} to finish.  #{a.to_i} % more than previous"
        end
      end
    end
    assert true
  end
end
