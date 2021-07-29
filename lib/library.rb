class Library
  attr_reader :name, :authors, :books, :checked_out_books

  def initialize(name)
    @name = name
    @authors = []
    @books = []
    @checked_out_books = []
  end

  def add_author(author)
    @authors << author
    add_books(author)
  end

  def add_books(author)
    @books += author.books
  end

  def publication_time_frame_for(author)
    first = author.first_book
    last = author.last_book

    {
      start: first.publication_year,
      end: last.publication_year
    }
  end

  def checkout(book)
    book.get_checked_out
    if has_book?(book)
      @checked_out_books << book
      return true
    end
    false
  end

  def return(book)
    @checked_out_books.delete(book)
  end

  def has_book?(book)
    @books.include?(book) && not_checked_out?(book)
  end

  def not_checked_out?(book)
    !@checked_out_books.include?(book)
  end

  def most_popular_book
    @books.max_by do |book|
      book.times_checked_out
    end
  end
end
