require 'imdb'
require 'filecache'

describe "Imdb::Movie" do
  describe "valid movie" do
    before(:all) do
      #IMDB.cache = FileCache.new("imdb", "/tmp")
      @movie = IMDB::Movie.new("0133093")
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
    
    it "should find the cast members" do
      cast = @movie.cast_members
    
      cast.should be_an(Array)
      cast[0][:name].should =~ /Keanu Reeves/
      cast[1][:name].should =~ /Laurence Fishburne/
      cast[2][:name].should =~ /Carrie-Anne Moss/
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
    
    
    it "should have directors" do
      directors = @movie.directors

      directors.should be_an(Array)      
      directors[0][:name].should include("Andy Wachowski")
      directors[1][:name].should include("Lana Wachowski")
    end
    
    it "should have a duration" do
      @movie.duration.should == 136
    end
    
    it "should have genres" do
      @movie.genres.should be_an(Array)
      @movie.genres.should include("Action")
      @movie.genres.should include("Adventure")
    end
    
    it "should have a language" do
      @movie.languages.should be_an(Array)
      @movie.languages.should include("English")
    end
    
    it "should have pictures" do
      @movie.pictures.should be_an(Array)
      @movie.pictures[0].should =~ /http:\/\/.*\.(?:jpg|gif|png)/
    end
    
    it "should have a plot" do
      @movie.plot.should == "A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against the controllers of it."
    end
    
    it "should have a poster" do
      @movie.poster.should =~ /http:\/\/.*\.(?:jpg|gif|png)/
    end
    
    it "should have a production date" do
      @movie.production_date.should be_an(Date)
      @movie.production_date.should == Date.strptime("1999", "%Y")
    end
    
    it "should have a rating" do
      @movie.rating.should be_an(Float)
      @movie.rating.should == 8.7      
    end
    
    it "should have a release date" do
      @movie.release_date.should be_an(Date)
      @movie.release_date.should == Date.strptime("23 June 1999", "%d %b %Y")
    end
    
    it "should have a tagline" do
      @movie.tagline.should == "Free your mind"
    end
    
    it "should have writer" do
      writers = @movie.writers
    
      writers.should be_an(Array)
      writers[0][:name].should == "Andy Wachowski"
      writers[1][:name].should == "Lana Wachowski"
    end
    
    it "should have a year" do
      @movie.year.should == 1999
    end
  end
end