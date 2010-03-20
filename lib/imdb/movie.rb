module IMDB
  class Movie
    def initialize(id = nil, cache = nil)
      @id = id unless id.nil?
      @cache = cache unless cache.nil?
    end
    
    def cast_members
      cast_members = []
      document.search("table.cast td.nm a").map do |link|
        link[:href] =~ /\/name\/nm(\d+)\//
        cast_members << { :url => IMDB::CASTING_URL % $1,
                          :id  => $1,
                          :name => link.innerHTML.strip.imdb_unescape_html }
      end
      cast_members
    end
    
    def color
      document.at("h5[text()='Color:'] ~ a").innerHTML.strip.imdb_unescape_html rescue nil
    end
 
    def company
      document.at("h5[text()='Company:'] ~ a[@href*=/company/']").innerHTML.strip.imdb_unescape_html rescue nil
    end
    
    def countries
      document.search("h5[text()='Country:'] ~ a[@href*=/Sections/Countries/']").map do |link|
        link.innerHTML.strip.imdb_unescape_html
      end rescue []
    end
        
    def title
      @title = document.at("h1").innerHTML.split('<span').first.strip.imdb_unescape_html
    end
    
    def valid?
      document
      @valid
    end
    
    def url
      IMDB::MOVIE_URL % @id
    end
    
    #private
      def document
        begin
          if @cache.nil?
            @document ||= Hpricot(open(self.url).read)
          else
            body = @cache.get(self.url)
            if body.nil?
              @document ||= Hpricot(open(self.url).read)
              @cache.set(self.url, @document)
            else
              @document ||= body
            end
          end
          @valid = true
        rescue
          @document = nil
          @valid = false
        end
        @document
      end
  end
end