class Rental
  attr_accessor :date, :person, :book

  def rental(date, person, book)
    @date = date
    @person = person
    @book = book
    @person.rentals << self
    @book.rentals << self
  end
end
