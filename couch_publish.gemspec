# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{couch_publish}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Parker"]
  s.date = %q{2011-01-15}
  s.description = %q{Rides on top of the `memories` gem to add simple publishing functionality with rollback and preview support.}
  s.email = %q{moonmaster9000@gmail.com}
  s.files = [
    "lib/couch_publish.rb",
    "lib/couch_publish/couch_publish.rb"
  ]
  s.homepage = %q{http://github.com/moonmaster9000/couch_publish}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Publishing functionality for couchdb documents.}
  s.test_files = [
    "spec/lib/couch_publish_spec.rb",
    "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<memories>, ["~> 0.3.2"])
    else
      s.add_dependency(%q<memories>, ["~> 0.3.2"])
    end
  else
    s.add_dependency(%q<memories>, ["~> 0.3.2"])
  end
end

