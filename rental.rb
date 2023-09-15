require 'securerandom'

class Rental
  attr_accessor :date, :book, :person, :id

  def initialize(date, book, person)
    @id = generate_id
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def generate_id
    SecureRandom.uuid
  end
end
