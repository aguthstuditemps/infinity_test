module InfinityTest
  module Observer
    module SharedExample
      # Shared Examples to use in the RSpec specs when you want create your own observer.
      #
      # ==== Examples
      #
      #   RSpec.configure do |config|
      #     config.include InfinityTest::Observer::SharedExample
      #   end
      #
      #   describe BarObserver do
      #     it_should_behave_like 'an infinity test observer'
      #   end
      #
      shared_examples_for 'an infinity test observer' do

        it 'should respond to #observer' do
          expect(subject).to respond_to(:observer)
        end

        it 'should respond to #watch_dir' do
          expect(subject).to respond_to(:watch_dir)
        end

        it 'should respond to #watch' do
          expect(subject).to respond_to(:watch)
        end

        it 'should respond to #start' do
          expect(subject).to respond_to(:start)
        end
      end
    end
  end
end