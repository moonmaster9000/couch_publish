require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name        = "couch_publish"
    gemspec.summary     = "Publishing functionality for couchdb documents."
    gemspec.description = "Rides on top of the `memories` gem to add simple publishing functionality with rollback and preview support."
    gemspec.email       = "moonmaster9000@gmail.com"
    gemspec.files       = FileList['lib/**/*.rb', 'README.rdoc']
    gemspec.homepage    = "http://github.com/moonmaster9000/couch_publish"
    gemspec.authors     = ["Matt Parker"]
    gemspec.add_dependency('memories', '~> 0.3.2')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler"
end
