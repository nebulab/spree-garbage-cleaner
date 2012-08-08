module Spree
  User.class_eval do
    def self.destroy_garbage
      self.garbage.destroy_all
    end
    
    def self.garbage
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      self.joins('LEFT JOIN spree_orders ON spree_orders.user_id = spree_users.id').where("
          (spree_users.email IS NULL OR spree_users.email LIKE ?) AND 
          spree_users.created_at <= ? AND spree_orders.completed_at IS NULL
        ", '%@example.net', garbage_after.days.ago
      )
    end

    def garbage?
      garbage_after = Spree::GarbageCleaner::Config.cleanup_days_interval
      anonymous? && created_at <= garbage_after.days.ago && orders.count == orders.incomplete.count
    end
  end
end