module Optie
  module Option
    class Base
      def some?
        false
      end

      def none?
        false
      end
    end

    class None < Base
      def none?
        true
      end

      def unwrap
        raise 'Unwrapped `None`'
      end

      def unwrap_or(default = nil)
        if block_given?
          yield
        else
          default
        end
      end

      def map
        self
      end

      def and(_other_option = nil)
        self
      end

      def or(other_option = nil)
        if block_given?
          yield
        else
          other_option
        end
      end
    end

    class Some < Base
      def initialize(value)
        @value = value
      end

      def some?
        true
      end

      def unwrap
        @value
      end

      def unwrap_or(_default = nil)
        @value
      end

      def map
        Some.new(yield @value)
      end

      # Calls the block and returns its value if block passed, otherwise
      # returns the argument's value
      def and(other_option = nil)
        if block_given?
          yield @value
        else
          other_option
        end
      end

      def or(_other_option = nil)
        self
      end
    end
  end
end
