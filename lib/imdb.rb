$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
 
require 'open-uri'
require 'rubygems'
require 'hpricot'

require 'imdb/movie'

module IMDB
  VERSION = '0.0.1'
end