require_relative './book'
require_relative './classroom'
require_relative './person'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require_relative './nameable'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def create_book
    puts 'Enter book\'s title'
    title = gets.chomp
    puts 'Enter author\'s name'
    author = gets.chomp
    puts 'Enter ISBN'
    isbn = gets.chomp
    book = Book.new(title, author, isbn)
    @books << book
    puts "Created #{book.title} by #{book.author}"
  end

  def list_books
    if @books.empty?
      puts 'There are no books to display currently'
    else
      @books.each do |book|
        puts "Title: '#{book.title}', Author: '#{book.author}' ID: '#{book.id}'"
      end
    end
  end

  def list_people
    if @people.empty?
      puts 'There\'s no one here currently'
    else
      @people.each do |person|
        puts "Name: #{person.name} Age: #{person.age} ID: #{person.id}"
      end
    end
  end

  def create_person
    puts 'I am a:'
    puts '1 - student'
    puts '2 - teacher'

    person_input = gets.chomp.to_i

    case person_input
    when 1 then create_student
    when 2 then create_teacher
    else
      raise 'Please choose a valid option, number 1 or 2'
    end
  end

  def create_student
    puts 'What is your name?'
    name = gets.chomp
    puts 'How old are you?'
    age = gets.chomp
    puts 'What grade are you?'
    classroom = gets.chomp
    puts 'Do you have your parents\' permission?'
    parent_permission = gets.chomp
    student = Student.new(name, age, classroom, parent_permission: parent_permission)
    @people << student
    puts 'Student successfully created'
  end

  def create_teacher
    puts 'What is your name?'
    name = gets.chomp
    puts 'How old are you?'
    age = gets.chomp
    puts 'Enter your specialization'
    specialization = gets.chomp
    teacher = Teacher.new(name, age, specialization)
    @people << teacher
    puts 'Teacher successfully created'
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

  def select_person
    return nil if @people.empty?

    people_options = @people.map.with_index(1) do |person, index|
      "Number: #{index} - Role: #{person.class.name}, Name: #{person.name}, ID: #{person.id}"
    end
    puts people_options

    person_id_input = gets.chomp.to_i
    return nil if person_id_input < 1 || person_id_input > @people.size

    @people[person_id_input - 1]
  end

  def create_rental
    puts 'Enter the person ID:'
    person_id = gets.chomp.to_i
    person = @people.find { |person| person.id == person_id }
    
    if person.nil?
      puts 'Person not found'
      return
    end
    
    puts 'Enter the book ID:'
    book_id = gets.chomp.to_i
    book = @books.find { |book| book.id == book_id }
    
    if book.nil?
      puts 'Book not found'
      return
    end
    
    rental_date = input_rental_date
    rental = Rental.new(rental_date, person, book)
    @rentals << rental
    
    puts 'Rental created successfully'
  end
  
  def input_rental_date
    puts 'Enter the rental date [yyyy-mm-dd]:'
    gets.chomp
  end

  def list_rentals_for_person(person_id)
    rentals = @rentals.select { |rental| rental.person.id == person_id }
    return puts 'No rentals found for the given person ID!' if rentals.empty?

    rentals.each do |rental|
      puts rental_info(rental)
    end
  end

  def rental_info(rental)
    "#{rental.book.title} by #{rental.book.author}, rented on #{rental.date}"
  end
end
