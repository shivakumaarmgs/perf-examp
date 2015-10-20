require 'csv'

namespace :test do
  Rake::TestTask.new(:validate_benchmark => ['test:benchmark']) do |t|
    t.libs << 'test'
    t.test_files = ['test/integration/validate_benchmark_test.rb']
  end
end
