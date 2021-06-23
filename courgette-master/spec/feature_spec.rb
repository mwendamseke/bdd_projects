require File.join(File.dirname(__FILE__), 'spec_helper')

describe Courgette::Feature do
  
  before do
    @feature = Courgette::Feature.new(Rails.root.join('features/user_eats_rabbits.feature').to_s)
  end
  
  describe '#name' do
    it "should return the feature's name" do
      @feature.name.should == "User eats a Rabbit"
    end
  end
  
  describe '#to_param' do
    it "should return the feature's path, relative to feature_root, parameterized and without .feature extension" do
      @feature.to_param.should == 'user_eats_rabbits'
    end
  end
  
  describe '#source' do
    it "should contain the feature text" do
      @feature.source.should include('In order to get that delicious feeling')
      @feature.source.should include('As a user')
      @feature.source.should include('I want to eat some Rabbits')
      @feature.source.should include('eat a really cute rabbit')
      @feature.source.should include('there is a rabbit')
      @feature.source.should include('the rabbit is really cute')
      @feature.source.should include('eat the rabbit')
      @feature.source.should include('should feel good')
    end
  end
  
  describe '#==' do
    it "should be equal if it has the same param" do
      @feature.should == Courgette::Feature.new(Rails.root.join('features/user_eats_rabbits.feature').to_s)
    end
  end
  
end