class Spree::GarbageCleanerConfiguration < Spree::Preferences::Configuration
  preference :models_with_garbage, :any, :default => "Spree::Order, #{Spree.user_class}"
  preference :cleanup_days_interval, :integer, :default => 7
  preference :batch_size, :integer, :default => 100
end
