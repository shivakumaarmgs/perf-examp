Run `rake test:validate_benchmark`


This will run the `rake test:benchmark` task first, then will
run a test defined at `/test/integration/validate_benchmark_test.rb`


The test defined at `/test/integration/validate_benchmark_test.rb` will 
check in every `*_wall_time.csv`s the percentage increase of time(measurements). 
If the % is greater than 10 it will assert failure else the test will pass.


Visit url `/csv` to see the wall time csv's generated for all the test
in a table format

### To Test
Run `rake test:validate_benchmark`


The only test available in `test/performance/homepage_test.rb` is 
`homepage` test. This will record the wall time for the homepage request


Now go to file `app/controllers/posts_controller.rb` and uncomment line
number 8. ie `sleep 2`


Now re-run the `rake test:validate_benchmark`, this will fail
