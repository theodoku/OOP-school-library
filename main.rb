require './app'
require './menu'

def main
  app = App.new
  menu = Menu.new(app)

  puts 'Welcome to the OOP School Library App'
  puts

  loop do
    choice = menu.menu

    menu.handle_choice(app, choice) 
  end
end

def exit_app
  puts 'Thank you for using this app!'
  exit
end

main
