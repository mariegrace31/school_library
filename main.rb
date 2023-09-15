require './app'
app = App.new

def main(app)
  puts 'Welcome to School Library App!'
  loop do
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    number = gets.chomp.to_i
    break if number == 7

    execute_option(app, number)
  end
end

def execute_option(app, number)
  case number
  when 1
    app.list_all_books
  when 2
    app.list_all_people
  when 3
    app.create_person_option
  when 4
    app.create_book_option
  when 5
    app.create_rental
  when 6
    app.get_rental_option
  end
end

main(app)
