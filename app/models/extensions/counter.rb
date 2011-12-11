module Extensions
  module Counter
    extend ActiveSupport::Concern

    module ClassMethods
      def has_counter(name = :size)
        define_method "change_#{name}" do |delta|
          Extensions::Counter.audit(false)
          current = send(name)
          update_attribute(name, current + delta)
          Extensions::Counter.audit(false)
        end
        
        define_method "increment_#{name}" do
          send("change_#{name}", 1)
        end
        define_method "decrement_#{name}" do
          send("change_#{name}", -1)
        end

      end
    end

    def self.audit(enabled)
      PaperTrail.enabled = enabled
      ActiveRecord::Base.record_timestamps = enabled
    end

  end
end
