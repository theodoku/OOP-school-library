require_relative './rental'

def load_rentals
  file_handler = FileHandler.new('./rentals.json')
  data = file_handler.read_from_file

  return if data.nil?

  rentals_data = JSON.parse(data)

  if rentals_data.is_a?(Array)
    load_rentals_from_array(rentals_data)
  else
    load_single_rental(rentals_data)
  end
end

def load_rentals_from_array(rentals_data)
  rentals_data.each do |rental_data|
    person_data = rental_data['Person']
    book_data = rental_data['Book']
    person = find_person_by_id(person_data[0])
    book = find_book_by_id(book_data[0])

    next if person.nil? || book.nil?

    rental = Rental.new(rental_data['Date'], person, book)
    @rentals << rental
  end
end

def load_single_rental(rental_data)
  person_data = rental_data['Person']
  book_data = rental_data['Book']
  person = find_person_by_id(person_data[0])
  book = find_book_by_id(book_data[0])

  return if person.nil? || book.nil?

  rental = Rental.new(rental_data['Date'], person, book)
  @rentals << rental
end

def find_person_by_id(person_id)
  @people.find { |person| person.id == person_id }
end

def find_book_by_id(book_id)
  @books.find { |book| book.id == book_id }
end
