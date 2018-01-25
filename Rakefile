require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

desc "Just sets up a skeleton environment, kinda like Rails would if we were using it"
task :environment do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__),'lib'))

  Dir[File.join(File.dirname(__FILE__), "lib" , "**/*.rb")].each do |f|
    require f
  end
end

task :default => [:environment, :spec] do
  
end

