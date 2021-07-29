class Library
  attr_reader :name, :authors, :books

  def initialize(name)
    @name = name
    @authors = []
    @books = []
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
end
