class Book
  attr_accessor :title, :id, :author, :rentals

  def initialize(title, author, _rental)
    @title = title
    @author = author
    @rentals = []
    @id = generate_id
  end

  def add_rental(date, person)
    Rental.new(date, person, self)
  end

  def generate_id
    rand(1..1000)
  end
end