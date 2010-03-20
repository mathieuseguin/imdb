require 'cgi'
require 'iconv'
 
module Imdb
  module StringExtensions
  
    def imdb_unescape_html
      Iconv.conv("UTF-8", 'ISO-8859-1', CGI::unescapeHTML(self))
    end
  
    def imdb_strip_tags
      gsub(/<\/?[^>]*>/, "")
    end
    
    def blank?
      strip.empty?
    end unless method_defined?(:blank?)
  end
end
 
String.send :include, Imdb::StringExtensions