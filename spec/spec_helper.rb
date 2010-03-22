begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'spec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'imdb'

load 'imdb_spec.rb'
load 'movie_spec.rb'
load 'search_spec.rb'