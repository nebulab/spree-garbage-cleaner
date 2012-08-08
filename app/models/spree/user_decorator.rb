module Spree
  User.class_eval do
    def self.destroy_garbage
      self.garbage.destroy_all
    end
    
    def self.garbage
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      garbage = self.joins('LEFT JOIN spree_orders ON spree_orders.user_id = spree_users.id')
      garbage = garbage.where("spree_users.email IS NULL OR spree_users.email LIKE ?", '%@example.net')
      garbage = garbage.where("spree_users.created_at <= ?", garbage_after.days.ago)
      garbage.where("spree_orders.completed_at IS NULL")
    end

    def garbage?
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      anonymous? && created_at <= garbage_after.days.ago && orders.count == orders.incomplete.count
    end
  end
end