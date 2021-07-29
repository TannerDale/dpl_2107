require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Author do
  context 'initialize' do
    dpl = Library.new("Denver Public Library")

    it 'exists' do
      expect(dpl).to be_a(Library)
    end

    it 'has attributes' do
      expect(dpl.name).to eq("Denver Public Library")
      expect(dpl.books).to be_empty
      expect(dpl.authors).to be_empty
    end
  end

  context 'adding authors' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    it 'can add authors and their books' do
      dpl.add_author(charlotte_bronte)
      dpl.add_author(harper_lee)

      expect(dpl.authors).to eq([charlotte_bronte, harper_lee])
      expect(dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
    end
  end

  context 'publicaton time frames' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    it 'has publication time frames' do
      expected_1 = {:start=>"1847", :end=>"1857"}
      expected_2 = {:start=>"1960", :end=>"1960"}

      expect(dpl.publication_time_frame_for(charlotte_bronte)).to eq(expected_1)
      expect(dpl.publication_time_frame_for(harper_lee)).to eq(expected_2)
    end
  end

  context 'checking out books' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)

    it 'cannot checkout a book it doesnt have' do
      test_book = Book.new({author_first_name: "Mike", author_last_name: "Dao", title: "Why VIM is the Best IDE", publication_date: "July 4, 2021"})

      expect(dpl.checkout(test_book)).to be(false)
    end

    it 'can checkout and return a book' do
      result = dpl.checkout(jane_eyre)
      dpl.checkout(mockingbird)

      expect(result).to be(true)
      expect(dpl.checked_out_books).to eq([jane_eyre, mockingbird])

      dpl.return(jane_eyre)

      expect(dpl.checked_out_books).to eq([mockingbird])

      dpl.return(mockingbird)

      expect(dpl.checked_out_books).to eq([])
    end

    it 'cannot checkout an already checked out book' do
      dpl.checkout(jane_eyre)

      result = dpl.checkout(jane_eyre)
      expect(result).to be(false)
      expect(dpl.checked_out_books).to eq([jane_eyre])

      dpl.return(jane_eyre)
    end

    it 'knows if it has a book' do
      expect(dpl.has_book?(mockingbird)).to be(true)
    end

    it 'knows if a book is not checked out' do
      expect(dpl.not_checked_out?(mockingbird)).to be(true)
    end
  end

  context 'most popular book' do
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)
    dpl.checkout(jane_eyre)

    dpl.checkout(villette)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)
    dpl.return(mockingbird)
    dpl.checkout(mockingbird)

    it 'has a most popular book' do
      expect(dpl.most_popular_book).to eq(mockingbird)
    end
  end
end
