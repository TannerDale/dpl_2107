class Book
  attr_reader :title, :publication_year

  def initialize(params)
    @title = params[:title]
    @author_first_name = params[:author_first_name]
    @author_last_name = params[:author_last_name]
    @publication_year = get_publication_year(params[:publication_date])
  end

  def author
    "#{@author_first_name} #{@author_last_name}"
  end

  def get_publication_year(date)
    date.split.last
  end
end
