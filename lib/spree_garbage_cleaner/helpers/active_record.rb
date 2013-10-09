module SpreeGarbageCleaner
  module Helpers
    module ActiveRecord
      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def destroy_garbage
          destroyed = []

          self.garbage.find_each(:batch_size => Spree::GarbageCleaner::Config.batch_size) do |r|
            destroyed << r.destroy
          end

          destroyed
        end
      end
    end
  end
end
