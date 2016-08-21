module InfinityTest
  module Core
    class AutoDiscover
      attr_reader :base

      def initialize(base)
        @base = base
      end

      def discover_libraries
        discover_strategy
        discover_framework
        discover_test_framework
      end

      def discover_strategy
        base.strategy = auto_discover(:strategy) if strategy == :auto_discover
      end

      def discover_framework
        base.framework = auto_discover(:framework) if framework == :auto_discover
      end

      def discover_test_framework
        base.test_framework = auto_discover(:test_framework) if test_framework == :auto_discover
      end

      private

      def auto_discover(library_type)
        klass = "InfinityTest::#{library_type.to_s.camelize}::Base"
        library_base_class = klass.constantize
        library = library_base_class.subclasses.find do |subclass|
          subclass.run?
        end

        if library.present?
          library.name.demodulize.underscore.to_sym
        else
          subclasses = library_base_class.subclasses.map { |subklass| subklass }
          message = %{
            The InfinityTest::Core::AutoDiscover doesn't discover nothing to run
            Are you using a #{library_type} that Infinity test knows?

            Infinity Test #{library_type.to_s.pluralize}: #{subclasses}
          }
          raise Exception, message
        end
      end
    end
  end
end
