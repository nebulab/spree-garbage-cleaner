module Spree
  Order.class_eval do
    def self.garbage
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      self.incomplete.where("created_at <= ?", garbage_after.days.ago)
    end

    def garbage?
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      completed_at.nil? && created_at <= garbage_after.days.ago
    end
  end
end