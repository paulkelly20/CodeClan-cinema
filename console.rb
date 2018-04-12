require_relative('models/customer.rb')
require_relative('models/films.rb')
require_relative('models/ticket.rb')
require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()

customer1 = Customer.new(
  "name" => "Paul Kelly",
  "funds" => "100"
)
customer1.save()

customer2 = Customer.new(
  "name" => "Elaine Mackay",
  "funds" => "70"
)
customer2.save()

film1 = Film.new(
  "title" => "Batman: Begins",
  "price" => "5"
)
film1.save()

film2 = Film.new(
  "title" => "Batman: The Dark Knight",
  "price" => "8"
)
film2.save()

tickets1 = Ticket.new(
  "customer_id" => customer1.id,
  "film_id" => film1.id
)

tickets1.save()

tickets2 = Ticket.new(
  "customer_id" => customer1.id,
  "film_id" => film2.id
)

tickets2.save()

tickets3 = Ticket.new(
  "customer_id" => customer2.id,
  "film_id" => film2.id
)
tickets3.save()

binding.pry
nil
