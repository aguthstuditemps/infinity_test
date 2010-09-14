module InfinityTest
  class Configuration
    
    SUPPORTED_FRAMEWORKS = [:growl] # :snarl, :lib_notify
    
    DEFAULT_DIR_IMAGES = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'images'))
    
    attr_accessor :notification_framework, :success_image, :failure_image, :rubies, :cucumber, :test_framework, 
                  :exceptions_to_ignore, :before_callback, :after_callback
    
    # Set the notification framework to use with Infinity Test.
    # The supported Notification Frameworks are:
    #
    # * Growl
    #
    # Here is the example of little Domain Specific Language to use:
    #
    # notifications :growl do
    #   on :sucess,  :show_image => :default # use default image in images/*
    #   on :failure, :show_image => 'Users/tomas/images/my_custom_image.png'
    # end
    #
    def notifications(framework, &block)
      raise NotificationFrameworkDontSupported, "Notification :#{framework} don't supported. The Frameworks supported are: #{SUPPORTED_FRAMEWORKS.join(',')}" unless SUPPORTED_FRAMEWORKS.include?(framework)
      @notification_framework = framework
      yield self if block_given?
      self
    end

    # Set the Success and Failure image to show in the notification framework
    #
    #   on :sucess,  :show_image => :default # use default image in images/*
    #   on :failure, :show_image => 'Users/tomas/images/my_custom_image.png'    
    # 
    def on(state, options={})
      if state == :success
        @success_image = setting_image(options, :default => 'success.png')
      elsif state == :failure
        @failure_image = setting_image(options, :default => 'failure.png')
      end
    end
    
    def setting_image(options, image={})
       if options[:show_image] == :default
         File.join(DEFAULT_DIR_IMAGES, image[:default])
       else
         options[:show_image]
       end
    end
    
    # The options method to set:
    # * test framework 
    # * ruby versions
    # * use cucumber or not
    # 
    # Here is the example of Little Domain Language:
    #
    # use :rubies => ['1.9.1', '1.9.2'], :test_framework => :rspec, :cucumber => true
    #
    # use :rubies => [ '1.8.7-p249', '1.9.2@rails3'], :test_framework => :test_unit
    #
    def use(options={})
      rubies = options[:rubies]
      @rubies = (rubies.is_a?(Array) ? rubies.join(',') : rubies) || []
      @cucumber = options[:cucumber] || false
      @test_framework = options[:test_framework] || :test_unit
    end
    
    # Method to use to ignore some dir/files changes
    # 
    # Example:
    #
    # ignore :exceptions => %w(.svn .hg .git vendor tmp config rerun.txt)
    #
    def ignore(options={})
      @exceptions_to_ignore = options[:exceptions] || []
    end
    
    # Callback method to run anything you want, before the run the test suite command
    # 
    # Example:
    #
    # before_run do
    #   system('clear')
    # end
    #
    def before_run(&block)
      @before_callback = block
    end
    
    # Callback method to run anything you want, after the run the test suite command
    # 
    # Example:
    #
    # after_run do
    #   # some code here
    # end
    #
    def after_run(&block)
      @after_callback = block
    end
    
    # Return true if the user set the cucumber option or otherwise return false
    #
    def use_cucumber?
      @cucumber
    end
    
    # Clear the terminal (Useful in the before callback)
    # 
    # NOTE: This only works in Unix systems
    #
    def clear(option)
      if option == :terminal
        system('clear')
      end
    end
    
  end
end

class NotificationFrameworkDontSupported < StandardError
end

def infinity_test(&block)
  configuration = InfinityTest.configuration
  configuration.instance_eval(&block)
  configuration
end
