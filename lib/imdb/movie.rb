module IMDB
  class Movie
    def initialize(id = nil)
      @id = id unless id.nil?
    end
  end
end