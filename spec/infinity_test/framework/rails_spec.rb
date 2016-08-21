require 'spec_helper'

module InfinityTest
  module Framework
    describe Rails do
      subject { Rails.new(Core::Base) }

      describe '#heuristics' do
        before { pending }

        it 'should add heuristics' do
          expect { subject.heuristics }.to_not raise_exception
        end
      end

      describe '.run?' do
        it 'returns true if exist the config/enviroment.rb file' do
          expect(File).to receive(:exist?)
            .with(File.expand_path('./config/environment.rb'))
            .and_return(true)
          expect(Rails).to be_run
        end

        it 'returns false if do not exist the config/enviroment.rb file' do
          expect(File).to receive(:exist?)
            .with(File.expand_path('./config/environment.rb'))
            .and_return(false)
          expect(Rails).not_to be_run
        end
      end
    end
  end
end
