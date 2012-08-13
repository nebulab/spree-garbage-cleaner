class GarbageCleanerConfiguration < Configuration
  preference :models_with_garbage, :string, :default => "Order, User"
  preference :cleanup_days_interval, :integer, :default => 7
end