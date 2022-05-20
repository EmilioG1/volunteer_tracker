require "volunteer"
require "project"
require "rspec"
require "pry"
require "pg"

# See README. Docker students MUST change line 8 to be compatible with Docker before initially starting their project. Else, they will need to start their project over from scratch.
DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec('DELETE FROM volunteers *;')
    DB.exec('DELETE FROM projects *;')
  end
end