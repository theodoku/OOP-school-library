require './app'
require './file_handler'

class Menu
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def menu
    puts 'Please select an option by entering its respective number:'
    display_menu_options
    gets.chomp.to_i
  end

  def display_menu_options
    menu_options = {
      1 => 'List all books',
      2 => 'List all people',
      3 => 'Create a person',
      4 => 'Create a book',
      5 => 'Create a rental',
      6 => 'List all rentals for a given person ID',
      7 => 'Exit'
    }

    menu_options.each { |index, option| puts "#{index} - #{option}" }
  end

  def handle_choice(app, choice)
    actions = {
      1 => :list_books,
      2 => :list_people,
      3 => :create_person,
      4 => :create_book,
      5 => :create_rental,
      6 => :list_rentals_for_person,
      7 => :exit_app
    }
    if actions.key?(choice)
      case choice
      when 6
        handle_list_rentals_for_person(app)
      when 7 then exit_app
      else
        app.send(actions[choice])
      end
    else
      puts 'Please choose a number between 1 and 7'
    end
  end

  def handle_list_rentals_for_person(app)
    puts 'Enter the person ID:'
    person_id = gets.chomp.to_i
    app.list_rentals_for_person(person_id)
  end

  def exit_app
    people = FileHandler.new('./people.json')
    people.write_to_file(@app.save_people.to_json)

    books = FileHandler.new('./book.json')
    books.write_to_file(@app.save_books.to_json)

    rental = FileHandler.new('./rentals.json')
    rental.write_to_file(@app.save_rentals.to_json)
    puts 'Thank you for using this apqp!'
    exit
  end
end
