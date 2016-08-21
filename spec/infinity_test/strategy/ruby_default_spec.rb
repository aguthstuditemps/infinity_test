require 'spec_helper'

module InfinityTest
  module Strategy
    describe RubyDefault do
      let(:base) { BaseFixture.new }
      let(:continuous_test_server) { Core::ContinuousTestServer.new(base) }
      subject { RubyDefault.new(continuous_test_server) }
      it_should_behave_like 'a infinity test strategy'

      describe '.run?' do
        it 'should return true when do not pass any ruby versions to run tests' do
          Core::Base.stub(:rubies).and_return([])
          expect(RubyDefault).to be_run
        end

        it 'should return false when pass some ruby version to run tests' do
          Core::Base.stub(:rubies).and_return(%w(ree jruby))
          expect(RubyDefault).not_to be_run
        end
      end

      describe '#run!' do
        before { base.test_framework = :rspec }

        it 'returns the command' do
          expect(subject.run!).to eq 'ruby -S rspec spec'
        end
      end
    end
  end
end
