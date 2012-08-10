class GarbageCleanerConfiguration < Configuration
  preference :models_with_garbage, :any, :default => "Spree::Order, Spree::User"
  preference :cleanup_days_interval, :integer, :default => 7
end