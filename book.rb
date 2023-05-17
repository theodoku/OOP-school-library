class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author, _rental)
    @title = title
    @author = author
    @rental = []
  end

  def add_rental(person, date)
    Rental.new(date, self, person)
  end
end
