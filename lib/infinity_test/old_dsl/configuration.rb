module InfinityTest
  module OldDSL
    # This class is DEPRECATED and will be removed on the next
    # versions.
    #
    class Configuration
      # Pass the responsability to InfinityTest::Base class.
      #
      # <b>Don't need #super or #respond_to here.</b>
      # <b>This class will be removed in infinity_test 2.0.1</b>
      #
      def respond_to_missing?(method_name, _include_private = true)
        true
      end

      # Pass the responsability to InfinityTest::Base class.
      #
      # <b>Don't need #super or #respond_to here.</b>
      # <b>This class will be removed in infinity_test 2.0.1</b>
      #
      def method_missing(method_name, *arguments, &block)
        InfinityTest::Base.send(method_name, *arguments, &block)
      end
    end

    module InfinityTestMethod
      # <b>DEPRECATED:</b> Please use <tt>InfinityTest::Base.setup</tt> instead.
      #
      def infinity_test(&block)
        message = <<-MESSAGE
        Infinity_test method is deprecated.
        Use InfinityTest.setup { |config| ... } instead."
        MESSAGE
        ActiveSupport::Deprecation.warn(message)
        ::InfinityTest::OldDSL::Configuration.new.instance_eval(&block)
      end
    end
  end
end

include InfinityTest::OldDSL::InfinityTestMethod
