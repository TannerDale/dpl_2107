class Book
  attr_reader :title, :author, :publication_year, :times_checked_out

  def initialize(params)
    @title = params[:title]
    @author = "#{params[:author_first_name]} #{params[:author_last_name]}"
    @publication_year = get_publication_year(params[:publication_date])
    @times_checked_out = 0
  end

  def get_publication_year(date)
    date.split.last
  end

  def get_checked_out
    @times_checked_out += 1
  end
end
