require_relative 'person'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'
require_relative 'rental'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def list_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end
  end

  def list_people
    @people.each do |person|
      puts "ID: #{person.id}, Name: #{person.name}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Is the person a Student(1) or a Teacher(2)? (Input the number)'
    type = gets.chomp.to_i

    case type
    when 1
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid option. Person creation failed.'
    end
  end

  def create_book
    puts "Enter book's title:"
    title = gets.chomp
    puts "Enter book's author:"
    author = gets.chomp

    book = Book.new(title, author)
    @books << book
    puts "Book created with ID: #{book.id}"
  end

  def create_rental
    return puts 'No people available to create a rental for.' if @people.empty?
    return puts 'No books available to create a rental for.' if @books.empty?

    selected_person = select_person
    selected_book = select_book

    return puts 'Invalid person selection. Rental creation failed.' if selected_person.nil?

    date = rental_date
    rental = create_new_rental(date, selected_book, selected_person)

    if add_rental_to_person(rental, selected_person)
      @rentals << rental
      puts "Rental created with ID: #{rental.id}"
    else
      puts 'Error adding rental to person.'
    end
  end

  def rental_date
    puts 'Enter rental date (YYYY-MM-DD):'
    gets.chomp
  end

  def create_new_rental(date, book, person)
    Rental.new(date, book, person)
  end

  def add_rental_to_person(rental, person)
    if person.respond_to?(:rentals) && person.rentals.is_a?(Array)
      person.rentals << rental
      true
    else
      false
    end
  end

  def list_rentals_for_person
    puts "Enter person's ID:"
    person_id = gets.chomp
    person = @people.find { |p| p.id == person_id }

    if person.nil?
      puts 'Person not found.'
      return
    end

    rentals = @rentals.select { |r| r.person.id == person_id }

    rentals.each do |rental|
      puts "ID: #{rental.id}, Book: #{rental.book.title}, Date: #{rental.date}"
    end
  end

  private

  def create_student
    puts "Enter student's name:"
    name = gets.chomp
    puts "Enter student's age:"
    age = gets.chomp.to_i
    parent_permission = ask_for_parent_permission
    student = Student.new(age, name, parent_permission: parent_permission)
    @people << student
    puts "Student created with ID: #{student.id}"
  end

  def create_teacher
    puts "Enter teacher's name:"
    name = gets.chomp
    puts "Enter teacher's age:"
    age = gets.chomp.to_i
    specialization = ask_for_teacher_specialization
    teacher = Teacher.new(age, name, specialization)
    @people << teacher
    puts "Teacher created with ID: #{teacher.id}"
  end

  def ask_for_parent_permission
    puts 'Is parent permission required? (y/n)'
    gets.chomp.downcase == 'y'
  end

  def ask_for_teacher_specialization
    puts "Enter teacher's specialization:"
    gets.chomp
  end

  def select_person
    puts 'Select a person from the following list by number (not ID):'
    list_people.each_with_index { |person, index| puts "#{index}. #{person.name}" }
    person_number = gets.chomp.to_i

    if person_number <= 0 || person_number >= @people.length
      puts 'Invalid selection. Rental creation failed.'
      return nil
    end

    @people[person_number]
  end

  def select_book
    puts 'Select a book from the following list by number:'
    list_books.each_with_index { |book, index| puts "#{index}. #{book.title} by #{book.author}" }
    book_number = gets.chomp.to_i

    if book_number.negative? || book_number >= @books.length
      puts 'Invalid selection. Rental creation failed.'
      return nil
    end

    @books[book_number]
  end
end
