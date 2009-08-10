REDCLOTH_FLAVORS = %w(ragel regexp treetop)

REDCLOTH_FLAVORS.each do |flavor|
  desc "Use the #{flavor.capitalize} version of RedCloth"
  task flavor do
    ENV['REDCLOTH_FLAVOR'] = REDCLOTH_FLAVOR = flavor
  end
end

require 'rubygems' 
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ["--options #{File.dirname(__FILE__) + '/spec/spec.opts'}"] 
  t.spec_files = FileList['spec/**/*_spec.rb'] 
end
task :spec => [:ensure_flavor_specified]
task :default => :spec

task :ensure_flavor_specified => [] do
  if ENV['REDCLOTH_FLAVOR'].nil?
    tasks = Rake::Task.tasks.select {|t| REDCLOTH_FLAVORS.include?(t.name) }
    message = "RedCloth flavor missing. Specify one with:\n"
    tasks.each do |task|
      message << "\trake #{task.name} #{ARGV.join(' ')}\n"
    end
    raise message
  end
end