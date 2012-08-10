module Spree
  module GarbageCleaner
    class Config
      include Singleton
      include PreferenceAccess

      class << self
        def instance
          return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
          GarbageCleanerConfiguration.find_or_create_by_name("GarbageCleaner configuration")
        end
      end
    end
  end
end