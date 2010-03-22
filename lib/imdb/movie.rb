module IMDB
  class Movie
    def initialize(id = nil, cache = nil)
      @id = id unless id.nil?
      IMDB.cache = cache unless cache.nil?
    end
    
    def cast_members
      cast_members = []
      document.search("table.cast td.nm a").map do |link|
        link[:href] =~ /\/name\/nm(\d+)\//
        cast_members << { :url => IMDB::CASTING_URL % $1,
                          :id  => $1,
                          :name => link.text.strip.imdb_unescape_html }
      end
      cast_members
    end
    
    def color
      document.at("h5[text()='Color:'] + div > a").text.strip.imdb_unescape_html rescue nil
    end
 
    # To update using http://www.imdb.com/title/ttXXXXXXX/companycredits
    def company
      document.at("h5[text()='Company:'] + div > a[@href*='/company/']").text.strip.imdb_unescape_html rescue nil
    end
    
    def countries
      document.search("h5[text()='Country:'] + div > a[@href*='/Sections/Countries/']").map do |link|
        link.text.strip.imdb_unescape_html
      end rescue []
    end
        
    def directors
      directors = []
      document.search("#director-info a").map do |link|
        link[:href] =~ /\/name\/nm(\d+)\//
        directors << {  :id => $1,
                        :url => IMDB::PERSON_URL % $1,
                        :name => link.text.strip.imdb_unescape_html }
      end
      directors
    end
    
    def duration
      document.search("h5[text()='Runtime:'] + div").text.scan(/(\d+) min/).map do |link|
        return $1.to_i
      end
    end
    
    def genres
      document.search("h5[text()='Genre:'] + div > a[@href*='/Sections/Genres/']").map do |link|
        link.text.strip.imdb_unescape_html
      end rescue []
    end
    
    def languages
      document.search("h5[text()='Language:'] + div > a[@href*='/Sections/Languages/']").map do |link|
        link.text.strip.imdb_unescape_html
      end rescue []
    end
    
    def pictures
      pictures = []
      document.search(".media_strip_thumb a").map do |link| 
        begin
          img_data = Nokogiri::HTML(IMDB::HTTP.get(IMDB::URL + link[:href]))
          link = img_data.at("#principal tr td img").attribute("src").text
          pictures << link if link
        rescue => e
          p e.message
          pictures = []
        end
      end
      pictures
    end
    
    def plot
      document.search("h5[text()^='Plot'] + div").children[0].text.strip.imdb_unescape_html rescue nil
    end
    
    def poster
      if @poster.nil?
        url = document.at("a[@name='poster']")['href'] rescue nil
        img_data = Nokogiri::HTML(open(IMDB::URL + url).read)
        @poster ||= img_data.at("#principal tr td img")['src'] rescue nil
      end
      @poster
    end
  
    def production_date
      Date.strptime(document.at("h1 > span > a").text.strip.imdb_unescape_html, "%Y") rescue nil
    end
  
    def rating
      document.search("h5[text()='User Rating:'] + div + div + div").text.strip.imdb_unescape_html.split('/').first.to_f rescue nil
    end
  
    def release_date
      date = document.search("h5[text()^='Release Date'] + div").text[/^\d{1,2} \w+ \d{4}/]
      Date.strptime(date, "%d %b %Y") rescue nil
    end
    
    def tagline
      document.search("h5[text()^='Tagline'] + div").children.first.text.strip.imdb_unescape_html rescue nil
    end
    
    def title
      @title ||= document.search("h1").children.first.text.strip.imdb_unescape_html rescue nil
    end
    
    def title=(title)
      @title = title
    end
    
    def url
      IMDB::MOVIE_URL % @id
    end
    
    def valid?
      document
      @valid
    end
    
    def writers
      writers = []
      document.search("h5[text()^='Writers'] + div > a").map do |link|
        link[:href] =~ /\/name\/nm(\d+)\//
        writers << { :url => IMDB::CASTING_URL % $1,
                     :id  => $1,
                     :name => link.text.strip.imdb_unescape_html }
      end.reject { |w| w == 'more' }.uniq rescue []
      writers
    end
    
    def year
      document.search('a[@href^="/year/"]').text.to_i rescue nil
    end
    
    private
      def document
        begin
          @document ||= Nokogiri::HTML(IMDB::HTTP.get(self.url))
          @valid = true
        rescue
          @document = nil
          @valid = false
        end
        @document
      end
  end
end