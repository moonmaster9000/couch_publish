Gem::Specification.new do |s|
  s.name        = "couch_publish"
  s.summary     = "Publishing functionality for couchdb documents."
  s.version     = File.read "VERSION"
  s.authors     = "Matt Parker"
  s.description = "Rides on top of the `memories` gem to add simple publishing functionality with rollback and preview support."
  s.email       = "moonmaster9000@gmail.com"
  s.files       = Dir["lib/**/*"]
  s.homepage    = "http://github.com/moonmaster9000/couch_publish"
  s.test_files  = Dir["spec/**/*"]
  s.add_dependency "memories", "~> 0.3.6"
  s.add_development_dependency "rspec"
end
