#Code taken from http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html

def run_cuke(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "bundle exec cucumber #{file}"
  puts
end


watch("features/.*\.feature") do |match|
  run_cuke match[0]
end

watch("features/step_definitions/(.*)_steps\.rb") do |match|
  affected_features = Dir.glob("features/#{match[1]}*.feature")
  affected_features.each do |f|
    run_cuke f
  end
end

##################################################
# RSpec 
##################################################


def run_spec(file)
  unless File.exist?(file)
    puts "#{file} does not exist"
    return
  end

  puts "Running #{file}"
  system "bundle exec rspec #{file}"
  puts
end


watch("spec/.*?/.*?_spec\.rb") do |match|
  run_spec match[0]
end

watch(%r{spec/factories( (?<all_factories>\.rb) | /(?<factory> .*?)\.rb )}x) do |match|
  if match["all_factories"]
    run_spec("spec/models")
  elsif match["factory"]
    run_spec("spec/models/#{match["factory"]}_spec.rb")
    #TODO: make this fine grained
    run_spec("spec/models/factories_spec.rb")
  end

end

watch("app/(.*?/.*?)\.rb") do |match|
  run_spec %{spec/#{match[1]}_spec.rb}
end
