module IMDB
  class Search
    def self.movie(query, options = [])
      movies  = {}
      types   = { :exact => "Titles (Exact Matches)", :popular => "Popular Titles", :partial => "Titles (Partial Matches)" }
      options = types.keys if options.empty?
      
      document = Nokogiri::HTML(IMDB::HTTP.get(IMDB::SEARCH_URL % CGI::escape(query)))
      options.each do |type|
        movies[type.to_sym] = []
        data = document.at_css("p b[text()*='#{types[type.to_sym]}']").parent.next
        movies[type.to_sym] |= parse_movies(data) unless data.nil?
      end
      movies
    end
    
    private
      def self.parse_movies(data)
        data.search('a[@href^="/title/tt"]').reject do |element|
          element.text.empty?
        end.map do |element|
          m = Movie.new(element['href'][/\d+/])
          m.title = element.text.strip.imdb_unescape_html
          m
        end
      end
  end
end