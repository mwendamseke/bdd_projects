Given /^a provider "([^\"]*)"$/ do |provider_name|
  Factory.create(:provider,:company_name => provider_name, :city => "Dublin")
end

Given /^"([^\"]*)" provides "([^\"]*)"$/ do |provider_name, service_name|
  Provider.find_by_company_name(provider_name).services << Service.find_by_name(service_name)
end

Given /^"([^\"]*)" has a minimum budget of "([^\"]*)"$/ do |provider_name, budget|
  Provider.find_by_company_name(provider_name).update_attribute(:min_budget, budget)
end

When /^I fill in the provider sign up form for "([^\"]*)"$/ do |provider_name|
  fill_in("Email", :with => "paul@rslw.com")
  fill_in('provider[email]', :with => 'info@rslw.com')
  fill_in("Password", :with => "password")
  fill_in("Retype password", :with => "password")
  fill_in("Company name", :with => "#{provider_name}")
  fill_in("Company website", :with => "http://www.rslw.com")
  fill_in("City", :with => "Dublin")
end

When /^I fill in the "([^\"]*)" with "([^\"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

Given /^a user "([^\"]*)" belonging to the "([^\"]*)" provider$/ do |username, provider|
  user = Factory.build(username)
  user.provider = Provider.find_by_company_name(provider)
  user.save!
end

Given /^a provider "([^\"]*)" belonging to "([^\"]*)"$/ do |provider, email|
  provider = Factory.create(:provider, :company_name => provider)
  user = Factory.create(:user, :email => email)
  provider.update_attribute(:user, user)
  user.update_attribute(:provider, provider)
end

Given /^an "([^\"]*)" provider "([^\"]*)"$/ do |state, provider|
  Factory.create(:provider, :company_name => provider, :aasm_state => state, :user => Factory.create(:user))
end

When /^I check the "([^\"]*)" checkbox$/ do |provider_name|
  provider = Provider.find_by_company_name(provider_name)
  check("provider_#{provider.id}")
end

Then /^the provider "([^\"]*)" checkbox should be checked$/ do |provider_name|
  provider = Provider.find_by_company_name(provider_name)
  field_with_id("provider_#{provider.id}").should be_checked
end

Given /^a portfolio item "([^\"]*)" belonging to the "([^\"]*)" provider$/ do |portfolio_item_name, provider|
  Factory.create(:portfolio_item, :name => portfolio_item_name, :provider => Provider.find_by_company_name(provider))
end

Given /^"([^\"]*)" is based in "([^\"]*)"$/ do |company_name, location|
  Provider.find_by_company_name(company_name).update_attributes(
    :state_province => location == "nowhere" ? "" : location.split(',').first.strip,
    :country => location == "nowhere" ? "" : location.split(',').last.strip)
end

Given /^"([^\"]*)" is located in "([^\"]*)"$/ do |company_name, city_state_country|
  Provider.find_by_company_name(company_name).update_attributes(
    :city => city_state_country == "nowhere" ? "" : city_state_country.split(',').first.strip,
    :state_province => city_state_country == "nowhere" ? "" : city_state_country.split(',')[1].strip,
    :country => city_state_country == "nowhere" ? "" : city_state_country.split(',').last.strip)
end