require 'imdb'

describe "Imdb::Movie" do
  it "should return an id" do
    IMDB.parse_id("http://www.imdb.com/title/tt0133093/").should == "0133093"
  end
end