require_relative './book'

def load_books
  @file_handler = FileHandler.new('./book.json')
  data = @file_handler.read_from_file
  return if data.nil?

  @save_books = JSON.parse(data)

  @save_books.each do |book_data|
    book = Book.new(book_data['Title'], book_data['Author'], book_data['id'])
    @books << book
  end
end
