require 'spec_helper'

describe PagePart do
  dataset :home_page
  
  test_helper :validations
  
  before do
    @original_filter = Radiant::Config['defaults.page.filter']
    @part = @model = PagePart.new(page_part_params)
  end

  after do
    Radiant::Config['defaults.page.filter'] = @original_filter
  end
  
  it "should take the filter from the default filter" do
    Radiant::Config['defaults.page.filter'] = "Pseudo Textile"
    part = PagePart.new :name => 'new-part'
    part.filter_id.should == "Pseudo Textile"
  end

  it "shouldn't override existing page_parts filters with the default filter" do
    part = PagePart.find(:first, :conditions => {:filter_id => nil})
    selected_filter_name = TextFilter.descendants.first.filter_name
    Radiant::Config['defaults.page.filter'] = selected_filter_name
    part.reload
    part.filter_id.should_not == selected_filter_name
  end
  
  it 'should validate length of' do
    {
      :name => 100,
      :filter_id => 25
    }.each do |field, max|
      assert_invalid field, ('this must not be longer than %d characters' % max), 'x' * (max + 1)
      assert_valid field, 'x' * max
    end
  end
  
  it 'should validate presence of' do
    [:name].each do |field|
      assert_invalid field, 'this must not be blank', '', ' ', nil
    end
  end
end

describe PagePart, 'filter' do
  dataset :markup_pages
  
  specify 'getting and setting' do
    @part = page_parts(:textile_body)
    original = @part.filter
    original.should be_kind_of(PseudoTextileFilter)
    
    @part.filter.should equal(original)
    
    @part.filter_id = 'Pseudo Markdown'
    @part.filter.should be_kind_of(PseudoMarkdownFilter)
  end
end
