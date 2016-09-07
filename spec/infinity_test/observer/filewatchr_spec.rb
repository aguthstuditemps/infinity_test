require 'spec_helper'

module InfinityTest
  module Observer
    describe Filewatchr do
      before { pending }
      it_should_behave_like 'an infinity test observer'

      describe '#watch' do
        it 'should pass the args to the observer'
      end

      describe '#watch_dir' do
        it 'should pass the pattern to the observer' do
          expect(subject.observer).to receive(:watch).with('^spec/*/(.*).rb')
          subject.watch_dir(:spec)
        end

        it 'should pass the pattern and the extension to the observer' do
          expect(subject.observer).to receive(:watch).with('^spec/*/(.*).py')
          subject.watch_dir(:spec, :py)
        end
      end

      describe '#start' do
        it 'should initialize an watchr controller passing the #observer' do
        end
      end
    end
  end
end
