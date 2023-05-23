class BookSelection
  def initialize(books)
    @books = books
  end

  def select_book
    return nil if @books.empty?

    book_options = @books.map.with_index(1) do |book, index|
      "Number: #{index} - Title: #{book.title}, Author: #{book.author}"
    end
    puts book_options

    book_id_input = gets.chomp.to_i
    return nil if book_id_input < 1 || book_id_input > @books.size

    @books[book_id_input - 1]
  end
end
