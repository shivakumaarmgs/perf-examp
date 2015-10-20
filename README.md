Run `rake test:validate_benchmark`


This will run the `rake test:benchmark` task first, then will
run a test defined at `/test/integration/validate_benchmark_test.rb`


The test defined at `/test/integration/validate_benchmark_test.rb` will 
check in every `*_wall_time.csv`s the percentage increase of time(measurements). 
If the % is greater than 10 it will assert failure else the test will pass.
