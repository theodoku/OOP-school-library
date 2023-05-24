# rubocop:disable all

require_relative './book'
require_relative './classroom'
require_relative './person'
require_relative './rental'
require_relative './student'
require_relative './teacher'
require_relative './nameable'
require_relative './book_selection'
require_relative './person_selection'
require_relative './file_handler'
require_relative './load_people'
require_relative './load_rentals'
require_relative './load_books'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
    @save_student = []
    @save_teachers = []
    @save_rentals = []
    @save_books = []
    @book_selection = BookSelection.new(@books)
    @person_selection = PersonSelection.new(@people)

    load_data
  end

  def create_book
    book_data = prompt_book_data
    book = Book.new(*book_data)
    @books << book
    @file_handler = FileHandler.new('./book.json')
    @save_student << {
      'Title' => book.title,
      'Author' => book.author,
      'id' => book.id
    }
    @file_handler.write_to_file(@save_student.to_json)
    puts "Created #{book.title} by #{book.author}"
  end

  def prompt_book_data
    puts 'Enter book\'s title'
    title = gets.chomp
    puts 'Enter author\'s name'
    author = gets.chomp
    puts 'Enter ISBN'
    isbn = gets.chomp
    [title, author, isbn]
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
    student_data = prompt_student_data
    student = Student.new(*student_data)
    @people << student
    @file_handler = FileHandler.new('./student.json')
    @save_student << {
      'Name' => student.name,
      'Age' => student.age,
      'ID' => student.id
    }
    @file_handler.write_to_file(@save_student.to_json)
    student.id
    puts 'Student successfully created'
  end

  def prompt_student_data
    puts 'What is your name?'
    name = gets.chomp
    puts 'How old are you?'
    age = gets.chomp
    puts 'What grade are you?'
    classroom = gets.chomp
    puts 'Do you have your parents\' permission?'
    gets.chomp
    [name, age, classroom]
  end

  def create_teacher
    teacher_data = prompt_teacher_data
    teacher = Teacher.new(*teacher_data)
    @people << teacher
    @file_handler = FileHandler.new('./teachers.json')
    @save_teachers << {
      'Name' => teacher.name,
      'Age' => teacher.age,
      'Specialization' => teacher.specialization,
      'ID' => teacher.id
    }
    @file_handler.write_to_file(@save_teachers.to_json)
    puts 'Teacher successfully created'
  end

  def prompt_teacher_data
    puts 'What is your name?'
    name = gets.chomp
    puts 'How old are you?'
    age = gets.chomp
    puts 'Enter your specialization'
    specialization = gets.chomp
    [name, age, specialization]
  end

  def create_rental
    puts 'Enter the person ID:'
    person_id = gets.chomp.to_i
    person = find_person_by_id(person_id)
    return puts 'Person not found' if person.nil?

    puts 'Enter the book ID:'
    book_id = gets.chomp.to_i
    book = find_book_by_id(book_id)
    return puts 'Book not found' if book.nil?

    rental_date = input_rental_date
    rental = Rental.new(rental_date, person, book)
    @rentals << rental

    save_rental_to_file(rental, person, book)

    puts 'Rental created successfully'
  end

  def find_person_by_id(person_id)
    @people.find { |p| p.id == person_id }
  end

  def find_book_by_id(book_id)
    @books.find { |b| b.id == book_id }
  end

  def save_rental_to_file(rental, person, book)
    @file_handler = FileHandler.new('./rentals.json')
    @save_rentals << {
      'Date' => rental.date,
      'Person' => {
        'Name' => person.name,
        'ID' => person.id
      },
      'Book' => {
        'Title' => book.title,
        'Author' => book.author,
        'ID' => book.id
      }
    }
    @file_handler.write_to_file(@save_rentals.to_json)
  end

  def input_rental_date
    puts 'Enter the rental date [yyyy-mm-dd]:'
    gets.chomp
  end

  def list_rentals_for_person(person_id)
    rentals = @rentals.select { |r| r.person.id == person_id }

    if rentals.empty?
      puts 'No rentals found for the person ID.'
    else
      rentals.each do |rental|
        person = rental.person
        book = rental.book
        puts "Rental Date: #{rental.date}"
        puts "Person ID: #{person.id}"
        puts "Person Name: #{person.name}"
        puts "Book ID: #{book.id}"
        puts "Book Title: #{book.title}"
        puts '---'
      end
    end
  end

  def handle_list_rentals_for_person
    puts 'Enter the person ID:'
    person_id = gets.chomp.to_i

    list_rentals_for_person(person_id)
  end

  def rental_info(date, _person, book)
    "#{book['Title']} by #{book['Author']}, rented on #{date}"
  end

  def select_book
    @book_selection.select_book
  end

  def select_person
    @person_selection.select_person
  end

  def load_data
    load_books
    load_people
    load_rentals
  end
end
