$LOAD_PATH.unshift './lib'
require 'rspec'
require 'couch_publish'

COUCHDB_SERVER = CouchRest.new "http://admin:password@localhost:5984"
COUCH_PUBLISH_TEST_DB = COUCHDB_SERVER.database!('couch_publish_test')

class Article < CouchRest::Model::Base
  include 'couch_publish'

  property :title
  property :body
end

RSpec.configure do |config|
  config.mock_with :rspec

  config.before(:each) do
    COUCH_PUBLISH_TEST_DB.recreate!
  end
end
