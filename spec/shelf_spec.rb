
describe Shelf do
  describe "empty shelf" do
    it "should have no books" do
      shelf = FactoryGirl.create(:shelf)
      shelf.books.count.should == 0
      shelf.books_count.should == 0
    end
  end

  it "sould have books" do
    shelf = FactoryGirl.create(:shelf)
    book = FactoryGirl.create(:book)
    shelf.add_book book, book.user
    shelf.books.count.should == 1
    shelf.books_count.should == 1
  end

end