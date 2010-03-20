require 'imdb'

describe "Imdb::Movie" do
  describe "valid movie" do
    before(:each) do
      @movie = IMDB::Movie.new("0133093")
    end

    it "should have an id" do
      @movie.id.should be_an(Integer)
    end
    
    it "should have a title" do
      @movie.title.should =~ /The Matrix/
    end
    
    it "should find the cast members" do
      cast = @movie.cast_members
    
      cast.should be_an(Array)
      cast.should include("Keanu Reeves")
      cast.should include("Laurence Fishburne")
      cast.should include("Carrie-Anne Moss")
    end
  end
end