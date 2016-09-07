require 'spec_helper'

module InfinityTest
  module Framework
    describe Padrino do
      subject { Padrino.new(Core::Base) }
      describe '#heuristics' do
        it 'add heuristics to padrino dir structure'
      end

      describe '.run?' do
        it 'should return true if find the config/apps.rb' do
          expect(File).to receive(:exist?)
            .with(File.expand_path('./config/apps.rb')).and_return(true)
          expect(Padrino).to be_run
        end

        it 'should return false if do not find the config/apps.rb' do
          expect(File).to receive(:exist?)
            .with(File.expand_path('./config/apps.rb')).and_return(false)
          expect(Padrino).not_to be_run
        end
      end
    end
  end
end
