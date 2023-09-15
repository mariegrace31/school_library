require_relative 'app'

def display_menu
  puts 'Please choose an option by entering a number:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List rentals for a given person ID'
  puts '7. Quit'
end

def list_books(app)
  app.list_books
end

def list_people(app)
  app.list_people
end

def create_person(app)
  app.create_person
end

def create_book(app)
  app.create_book
end

def create_rental(app)
  app.create_rental
end

def list_rentals_for_person(app)
  app.list_rentals_for_person
end

def exit_program(_app = nil)
  puts 'Thank you for using this app.'
  exit
end

OPTIONS = {
  1 => method(:list_books),
  2 => method(:list_people),
  3 => method(:create_person),
  4 => method(:create_book),
  5 => method(:create_rental),
  6 => method(:list_rentals_for_person),
  7 => method(:exit_program)
}.freeze

def execute_option(app, option)
  handler = OPTIONS[option]
  if handler
    handler.call(app)
  else
    puts 'Invalid option. Please try again.'
  end
end

def main
  app = App.new

  loop do
    display_menu
    option = gets.chomp.to_i
    execute_option(app, option)
  end
end

main
