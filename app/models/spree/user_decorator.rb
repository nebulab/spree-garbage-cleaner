module Spree
  User.class_eval do
    def self.garbage
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      self.where("(email IS NULL OR email LIKE ?) AND created_at <= ?", '%@example.net', garbage_after.days.ago)
    end

    def garbage?
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      anonymous? && created_at <= garbage_after.days.ago
    end
  end
end