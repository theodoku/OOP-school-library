require_relative '../book'

RSpec.describe Book do
  describe '#Book Test' do
    it 'should create new book' do
      title = 'Super Gene'
      author = 'Twelve Winged Dark Seraphim'
      book = Book.new(title, author, nil)
      expect(book.title).to eq(title)
      expect(book.author).to eq(author)
    end
  end
end
