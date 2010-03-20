require 'imdb'

describe "Imdb::Movie" do
  describe "valid movie" do
    before(:all) do
      @movie ||= IMDB::Movie.new("0133093")
    end

    it "should have an id" do
      @movie.id.should be_an(Integer)
    end

    it "should have a valid url" do
      @movie.url.should == "http://www.imdb.com/title/tt0133093/"
    end

    it "should have a valid document" do
      @movie.valid?.should be_true 
    end
    
    it "should have a title" do
      @movie.title.should =~ /The Matrix/
    end
    
    it "should have be color" do
      @movie.color.should =~ /Color/
    end
    
    it "should have a company" do
      @movie.company.should =~ /Groucho II Film Partnership/
    end
    
    it "should have countries" do
      countries = @movie.countries

      countries.should be_an(Array)      
      countries.should include("USA")
      countries.should include("Australia")
    end
    
    it "should find the cast members" do
      cast = @movie.cast_members
    
      cast.should be_an(Array)
      cast[0][:name].should =~ /Keanu Reeves/
      cast[1][:name].should =~ /Laurence Fishburne/
      cast[2][:name].should =~ /Carrie-Anne Moss/
    end
  end
end