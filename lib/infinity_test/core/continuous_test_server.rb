module InfinityTest
  module Core
    class ContinuousTestServer
      attr_reader :base
      delegate :binary, :test_files, to: :test_framework
      delegate :infinity_and_beyond, :notifications, :extension, to: :base

      def initialize(base)
        @base = base
      end

      def start
        run_strategy
        start_observer
      end

      # Run strategy based on the choosed ruby strategy.
      #
      def run_strategy
        # PENDING: run_before_callbacks

        notify(strategy.run)

        # PENDING: run_after_callbacks
      end

      # Re run strategy changed the changed files.
      #
      def rerun_strategy(files)
        test_framework.test_files = files
        run_strategy
      ensure
        test_framework.test_files = nil
      end

      def notify(strategy_result)
        if notifications.present?
          test_framework.test_message = strategy_result

          Core::Notifier.new(
            library: notifications,
            test_framework: test_framework
          ).notify
        end
      end

      # Start to monitoring files in the project.
      #
      def start_observer
        if infinity_and_beyond.present?
          framework.heuristics!
          observer.start!
        end
      end

      # Returns the instance for the configured strategy.
      #
      def strategy
        klass = "InfinityTest::Strategy::#{base.strategy.to_s.classify}"
        @strategy ||= klass.constantize.new(self)
      end

      # Return a cached test framework instance.
      #
      def test_framework
        klass = "::InfinityTest::TestFramework::#{base.test_framework.to_s.classify}"
        @test_framework ||= klass.constantize.new
      end

      # Return a framework instance based on the base framework accessor.
      #
      def framework
        klass = "::InfinityTest::Framework::#{base.framework.to_s.camelize}"
        @framework ||= klass.constantize.new(self)
      end

      # Return a cached observer instance by the observer accessor.
      #
      def observer
        klass = "::InfinityTest::Observer::#{base.observer.to_s.classify}"
        @observer ||= klass.constantize.new(self)
      end
    end
  end
end
