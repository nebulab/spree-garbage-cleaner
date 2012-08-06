class Spree::GarbageCleanerConfiguration < Spree::Preferences::Configuration
  preference :cleanup_days_interval, :integer, :default => 7
end