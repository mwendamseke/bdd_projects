require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Endorsement do
  before(:each) do
    @provider = Factory.create(:test_provider)
  end

  it "should activate the provider if it is the third endorsement" do
    Notification.should_receive(:deliver_endorsement_notification).exactly(3).times
    @provider.endorsements << Factory.create(:test_endorsement, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'inactive'
    @provider.endorsements << Factory.create(:test_endorsement, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'inactive'
    @provider.endorsements << Factory.create(:test_endorsement, :provider => @provider, :aasm_state => 'approved')
    @provider.status.should == 'active'
  end
end
