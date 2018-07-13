RSpec.configure do |config|
  config.before(:each) do
    LegacyRecord.connection.begin_transaction joinable: false
  end

  config.after(:each) do
    LegacyRecord.connection.rollback_transaction
  end
end
