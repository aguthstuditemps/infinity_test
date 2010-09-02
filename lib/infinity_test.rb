module InfinityTest
  autoload :Application, 'infinity_test/application'
  autoload :BinaryPath, 'infinity_test/binary_path'
  autoload :Configuration, 'infinity_test/configuration'
  autoload :ContinuousTesting, 'infinity_test/continuous_testing'
  autoload :Cucumber, 'infinity_test/cucumber'
  autoload :Options, 'infinity_test/options'
  autoload :Rspec, 'infinity_test/rspec'
  autoload :Runner, 'infinity_test/runner'
  autoload :TestUnit, 'infinity_test/test_unit'

  def self.application
    @application ||= Application.new
  end
  
  def self.start!
    Runner.new(Options.new(ARGV)).run!    
  end

end