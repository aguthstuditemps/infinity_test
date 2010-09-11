require 'spec_helper'

module InfinityTest
  describe Configuration do
    before { @config = Configuration.new }
    let(:config) { @config }
    
    describe '#infinity_test' do
      
      it "Infinity test Dsl of config file should yield in the Configuration scope" do
        infinity_test do
          use
        end.class.should equal Configuration
      end
      
    end
    
    describe '#notifications' do
      
      it "should possible to set the growl notification framework" do
        config.notifications :growl
        config.notification_framework.should equal :growl
      end
      
      it "should possible to set the snarl notification framework" do
        config.notifications :snarl
        config.notification_framework.should equal :snarl
      end
      
      it "should possible to set the lib notify notification framework" do
        config.notifications :lib_notify
        config.notification_framework.should equal :lib_notify
      end
      
      it "should not possible to set another notification framework" do
        lambda { config.notifications(:dont_exist) }.should raise_exception(NotificationFrameworkDontSupported, "Notification :dont_exist don't supported. The Frameworks supported are: growl,snarl,lib_notify")
      end
      
      it "should raise exception for non supported notification framework" do
        lambda { config.notifications(:snarfff) }.should raise_exception(NotificationFrameworkDontSupported, "Notification :snarfff don't supported. The Frameworks supported are: growl,snarl,lib_notify")
      end
      
    end

    describe '#use' do
      
      it "should set the rvm versions" do
        config.use :rubies => '1.8.7-p249'
        config.rubies.should be == '1.8.7-p249'
      end
      
      it "should set many ruby versions" do
        config.use :rubies => ['1.9.1', '1.9.2']
        config.rubies.should be == '1.9.1,1.9.2'
      end
      
      it "should return a empty collection when not set the rvm option" do
        config.use :cucumber => true
        config.rubies.should be_empty
      end
      
      it "should set the cucumber option" do
        config.use :cucumber => true
        config.use_cucumber?.should be_true
      end
      
      it "should return the false object when not use cucumber" do
        config.use :rvm => []
        config.use_cucumber?.should equal false
      end
      
      it "should set the test unit when not set the test framework" do
        config.use
        config.test_framework.should equal :test_unit
      end
      
      it "should return the test framework" do
        config.use :test_framework => :rspec
        config.test_framework.should equal :rspec
      end
      
      it "should possible to set the test unit for test framework" do
        config.use :test_framework => :test_unit
        config.test_framework.should equal :test_unit
      end
      
    end

    describe '#ignore' do
      
      it "should be empty when not have dir/files to ignore" do
        config.ignore
        config.exceptions_to_ignore.should be == []
      end
      
      it "should set the exception to ignore" do
        config.ignore :exceptions => %w(.svn)
        config.exceptions_to_ignore.should be == %w(.svn)
      end
      
      it "should set the exceptions to ignore changes" do
        config.ignore :exceptions => %w(.svn .hg .git vendor tmp config rerun.txt)
        config.exceptions_to_ignore.should be == %w(.svn .hg .git vendor tmp config rerun.txt)
      end
      
    end

    describe '#before_run' do
      
      it "should persist the proc object in the before callback" do
        proc = Proc.new { 'To Infinity and beyond!' }
        config.before_run(&proc)
        config.before_callback.should be == proc
      end
      
    end
    
    describe '#after_run' do
      
      it "should persist the proc object in the after callback" do
        proc = Proc.new { 'To Infinity and beyond!' }
        config.after_run(&proc)
        config.after_callback.should be == proc
      end
      
    end

  end
end