User.class_eval do
  def self.destroy_garbage
    self.garbage.destroy_all
  end
  
  def self.garbage
    garbage_after = Spree::GarbageCleaner::Config[:cleanup_days_interval]
    garbage = self.joins('LEFT JOIN orders ON orders.user_id = users.id')
    garbage = garbage.where("users.email IS NULL OR users.email LIKE ?", '%@example.net')
    garbage = garbage.where("users.created_at <= ?", garbage_after.days.ago)
    garbage.where("orders.completed_at IS NULL")
  end

  def garbage?
    garbage_after = Spree::GarbageCleaner::Config[:cleanup_days_interval]
    anonymous? && created_at <= garbage_after.days.ago && orders.count == orders.incomplete.count
  end
end
