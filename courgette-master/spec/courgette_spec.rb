require File.join(File.dirname(__FILE__), 'spec_helper')

describe Courgette do
  
  describe '.features' do
    it "should return a list of Courgette::Feature objects" do
      Courgette.features.first.should be_an_instance_of(Courgette::Feature)
      Courgette.features.second.should be_an_instance_of(Courgette::Feature)
    end
    
    it "should glob the path for feature files and get them by path" do
      Courgette.features.map(&:path).should include(Rails.root.join('features/user_eats_rabbits.feature').to_s)
      Courgette.features.map(&:path).should include(Rails.root.join('features/business/visitor_transforms.feature').to_s)
    end
  end

  
  describe '.first' do
    it "should return the first feature" do
      Courgette.first.should == Courgette.features.first
    end
  end

  # these 2 methods should replace get_dirs & get_files
  # test drive these before to see what they returns
  describe '.feature_folders' do
    it "should find all folders containing *.feature files within the 'features' folder if no argument is specified" do
      Courgette.feature_folders.should include('business')
    end

    it "should not find sub directories" do
      Courgette.feature_folders.should_not include('subdomain')
    end

    it "should not include step_definitions & support folders" do
      Courgette.feature_folders.should_not include('step_definitions')
      Courgette.feature_folders.should_not include('support')
    end

    it "should find all folders for a relative path" do
      Courgette.feature_folders('business').should include('subdomain')
    end
  end

  describe '.feature_filenames' do
    it "should return all the *.feature filenames of the features folder if no argument is specified" do
      Courgette.feature_filenames.should == ['user_eats_rabbits']
    end

    it "should return all filenames for a relative path" do
      Courgette.feature_filenames('business').should include('visitor_transforms')
    end
  end

  # then add action to CourgetteController and refactor the treeview view

  describe '.find' do
    it "should find a feature by its relative path" do
      @feature = Courgette.find('user_eats_rabbits')
      @feature.should be_an_instance_of(Courgette::Feature)
      @feature.path.should == Rails.root.join('features/user_eats_rabbits.feature').to_s
    end

    it "should allow the user to use the same filename in different folders" do
      Courgette.find('business/visitor_transforms').should be_an_instance_of(Courgette::Feature)
      Courgette.find('business/subdomain/user_eats_rabbits').should be_an_instance_of(Courgette::Feature)
    end
  end

end