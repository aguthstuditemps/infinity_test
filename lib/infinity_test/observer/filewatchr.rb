module InfinityTest
  module Observer
    class Filewatchr < Base
      attr_reader :observer

      def initialize(continuous_test_server)
        super
      end

      # ==== Examples
      #
      #   watch('lib/(.*)\.rb') { |file| puts [file.name, file.path, file.match_data] }
      #   watch('test/test_helper.rb') { run_all() }
      #
      def watch(pattern_or_file, &block)
        @observer
      end

      # ==== Examples
      #
      #   watch_dir(:lib)  { |file| RunTest(file) }
      #   watch_dir(:test) { |file| RunFile(file) }
      #
      #   watch_dir(:test, :py) { |file| puts [file.name, file.path, file.match_data] }
      #   watch_dir(:test, :js) { |file| puts [file.name, file.path, file.match_data] }
      #
      def watch_dir(dir_name, extension = :rb, &block)
      end

      # Start the continuous test server.
      #
      def start
      end
    end
  end
end
