require 'rubygems'
require 'rake'

require 'spec/rake/spectask'
require 'spec'

require 'cucumber'
require 'cucumber/rake/task'

Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

task :features do
  sh %{ cucumber features/ }
end

# cuke + bundler + capybara + envjs does not load envjs ???
#bundle exec /Users/jeanmichel/.rvm/rubies/ruby-1.8.7-p302/bin/ruby -I "/Users/jeanmichel/.rvm/gems/ruby-1.8.7-p302@courgette/gems/cucumber-0.9.0/lib:lib" "/Users/jeanmichel/.rvm/gems/ruby-1.8.7-p302@courgette/gems/cucumber-0.9.0/bin/cucumber" features --format progress
#no such file to load -- capybara/envjs (MissingSourceFile)


#Cucumber::Rake::Task.new(:features) do |t|
#  t.cucumber_opts = "features --format progress"
#end

task :default => [:spec, :features]