$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
 
require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'filecache'
require 'digest/md5'
require 'cgi'

require 'imdb/http'
require 'imdb/movie'
require 'imdb/search'
require 'imdb/string_extensions'

module IMDB
  VERSION = '0.0.2'
  
  URL               = "http://www.imdb.com"
  
  SEARCH_URL        = "http://www.imdb.com/find?q=%s;s=tt"          
  MOVIE_URL         = "http://www.imdb.com/title/tt%s/"
  CASTING_URL       = "http://www.imdb.com/name/nm%s/"
  PERSON_URL        = "http://www.imdb.com/name/nm%s/"
  
  def self.cache
    @cache
  end
  
  def self.cache=(cache)
    @cache = cache
  end
  
  def self.parse_id(url)
    $1 if url =~ /http:\/\/.*?\.imdb\.com\/title\/tt(\d+)/
  end
end