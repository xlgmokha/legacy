require 'rails_helper'

describe Business do
  let(:db_path) { File.expand_path(Rails.configuration.x.legacy[Rails.env]["database"]) }

  specify { expect(described_class.connection.instance_variable_get(:@config)[:database]).to eql(db_path) }
  specify { expect(described_class.count).to be_zero }
end
