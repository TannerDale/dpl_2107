require './lib/book'

RSpec.describe Book do
  context 'initialize' do
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

    it 'exists' do
      expect(book).to be_a(Book)
    end

    it 'has attributes' do
      expect(book.title).to eq("To Kill a Mockingbird")
      expect(book.author).to eq("Harper Lee")
      expect(book.publication_year).to eq("1960")
    end

    it 'can get a year from a date' do
      expect(book.get_publication_year("July 11, 1960")).to eq("1960")
    end
  end
end
