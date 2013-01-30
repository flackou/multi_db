require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require MULTI_DB_SPEC_DIR + '/../lib/multi_db/query_cache_compat'
require MULTI_DB_SPEC_DIR + '/../lib/multi_db/connection_proxy'
require MULTI_DB_SPEC_DIR + '/../lib/multi_db/observer_extensions'
require MULTI_DB_SPEC_DIR + '/../lib/multi_db/active_record_extensions'
require MULTI_DB_SPEC_DIR + '/../lib/multi_db/scheduler'

describe MultiDb::ActiveRecordExtensions do
  before(:each) do
    MultiDb::ConnectionProxy.setup!
    class Foo < ActiveRecord::Base; end
    class FooObserver < ActiveRecord::Observer; end
    ActiveRecord::Base.observers << :foo_observer
    ActiveRecord::Base.instantiate_observers
  end

  it "should allow subclassing an observed AR Model" do
    lambda { class FooBar < Foo; end }.should_not raise_error
  end
end