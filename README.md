Sample app for validating the wall time benchmarks. 

### How it works?
* Run the following rake task
```ruby
  namespace :test do
    Rake::TestTask.new(:validate_benchmark => ['test:benchmark']) do |t|
      t.libs << 'test'
      t.test_files = ['test/integration/validate_benchmark_test.rb']
    end
  end
```

* It first runs the `rake test:benchmark` task which will generate benchmarks
csv for all the given test scenarios.

* The the test defined at `test/integration/validate_benchmark_test.rb` will be executed
```ruby
  test "validate time benchmarks are good" do
    csv_files = Dir.glob "#{Rails.root}/tmp/performance/*_wall_time.csv"
    csv_files.each do |csv_file|
      old, new = CSV.open(csv_file).to_a[-2,2].map(&:first).map(&:to_f)
      # calculate % increase in time if greater than 10 assert false
      if(old and new and old != 0)
        a = (new-old)/old * 100
        if(a> 10)
        assert false, "Validating #{csv_file.split('#').last}. Last request took around #{new} to finish.  #{a.to_i} % more than previous"
        end
      end
    end
    assert true
  end
```

* Above test compares last 2 measuremnent times recorded in all `*_wall_time.csv` 
files inside the directory `tmp/performance/` where the performance benchmark results
are generally stored.

* The measuremnent times are compared for the percentage increase. If the
percentage increase of time is greater than 10(for now hardcoded) the test will
fail, it its lesser than 10 the test will pass.

* Visit url `/csv` to view the history of wall time benchmarks recorded for all the 
tests, including the percentage increase in time between each tests.

### To Test
* There is one performance test at `test/performace/homepage_test.rb`
```ruby
  test "homepage" do
    get '/'
  end
```
The homepage (ie) root is set to `PostsController#index` action

* Run `rake test:validate_benchmark`.

* Goto PostsController#index action and uncomment line 8, then again run
`rake test:validate_benchmark`.

* There will be a significant increase in walltime hence the test will fail.

* Comment the line 8 again at `posts_controller.rb` file then run the rake again
the test will now pass.

* Visit url `/csv` to view the history of wall time benchmarks recorded for all the 
tests, including the percentage increase in time between each tests.
