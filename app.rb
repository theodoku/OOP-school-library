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
  end

  def create_book
    book_data = prompt_book_data
    book = Book.new(*book_data)
    @books << book
    @file_handler = File_Handler.new('./book.json')
    @save_student << {
      "Title" => book.title,
      "Author" => book.author,
      "id" => book.id,
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
    @file_handler = File_Handler.new('./student.json')
    @save_student << {
      "Age" => student.age,
      "Name" => student.name,
      "ID" => student.id
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
    @file_handler = File_Handler.new('./teachers.json')
    @save_teachers << {
      "Age" => teacher.age,
      "Name" => teacher.name,
      "Specialization" => teacher.specialization,
      "ID" => teacher.id
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
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found'
      return
    end

    puts 'Enter the book ID:'
    book_id = gets.chomp.to_i
    book = @books.find { |b| b.id == book_id }

    if book.nil?
      puts 'Book not found'
      return
    end

    rental_date = input_rental_date
    rental = Rental.new(rental_date, person, book)
    @rentals << rental

    @file_handler = File_Handler.new('./rentals.json')
    @save_rentals << {
      "Date" => rental.date,
      "Person"  => [
        "Name" => person.name,
        "ID" => person.id
      ],
      "Book" => [
        "Title" => book.title,
        "Author" => book.author,
        "ID" => book.id
      ],
    }
    @file_handler.write_to_file(@save_rentals.to_json)

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

  def select_book
    @book_selection.select_book
  end

  def select_person
    @person_selection.select_person
  end
end
