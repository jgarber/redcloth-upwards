case ENV['REDCLOTH_FLAVOR']
when "ragel"
  require 'rubygems'
  gem 'RedCloth', ">= 4.0"
when "treetop"
  require 'rubygems'
  gem 'polyglot', "> 0.2.5" # 0.2.5 had a bug with absolute paths
  $:.unshift(File.dirname(__FILE__) + '/../vendor/redcloth-treetop/lib')
when "regexp"
  $:.unshift(File.dirname(__FILE__) + '/../vendor/redcloth-regexp/lib')
end

require 'redcloth'