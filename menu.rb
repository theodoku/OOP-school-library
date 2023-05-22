require './app'

class Menu
    def initialize(app)
        @ppp = app
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
  
 
