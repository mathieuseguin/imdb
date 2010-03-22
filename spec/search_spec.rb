require 'imdb'
require 'filecache'

describe "IMDB::Movie" do
  describe "valid search" do
    before(:all) do
      @movies = IMDB::Search.movie("Matrix")
    end
    
    it "should find an exact match" do
      @movies[:exact].first.id == "0106062"
    end
  end
end
