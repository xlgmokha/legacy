class ApplicationController < ActionController::Base
  around_action :cache_legacy_connections

  private

  def cache_legacy_connections
    LegacyRecord.connection.cache { yield }
  end
end
