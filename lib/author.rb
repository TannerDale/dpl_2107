class Author
  attr_reader :books

  def initialize(params)
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @books = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def write(title, year)
    book = Book.new({
      author_first_name: @first_name,
      author_last_name: @last_name,
      title: title,
      publication_date: year,
    })
    @books << book
    book
  end

  def first_book
    @books.min_by do |book|
      book.publication_year
    end
  end

  def last_book
    @books.max_by do |book|
      book.publication_year
    end
  end
end
