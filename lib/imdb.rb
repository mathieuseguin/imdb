$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
 
require 'rubygems'
require 'open-uri'
require 'hpricot'
require 'cgi'

require 'imdb/movie'
require 'imdb/string_extensions'

module IMDB
  VERSION = '0.0.1'
  
  URL                     = "http://www.imdb.com"
  
  SEARCH_URL        = "http://www.imdb.com/find?q=%s;s=tt"          
  MOVIE_URL         = "http://www.imdb.com/title/tt%s/"
  CASTING_URL       = "http://www.imdb.com/name/nm%s/"
  PERSON_URL        = "http://www.imdb.com/name/nm%s/"
  
  def self.parse_id(url)
    $1 if url =~ /http:\/\/.*?\.imdb\.com\/title\/tt(\d+)/
  end
end