require_relative('models/customer.rb')
require_relative('models/films.rb')
require_relative('models/ticket.rb')
require_relative('models/screening.rb')
require('pry-byebug')

Ticket.delete_all()
Customer.delete_all()
Film.delete_all()
Screening.delete_all()

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

screening1 = Screening.new(
  "screening_time" => "21:00",
  "film_id" => film1.id,
  "capacity" => 3
)
screening1.save()

screening2 = Screening.new(
  "screening_time" => "22:00",
  "film_id" => film1.id,
  "capacity" => 10
)

screening2.save()

screening3 = Screening.new(
  "screening_time" => "23:00",
  "film_id" => film2.id,
  "capacity" => 90
)

screening3.save()


tickets1 = Ticket.new(
  "customer_id" => customer1.id,
  "screening_id" => screening1.id
)

tickets1.save()

tickets2 = Ticket.new(
  "customer_id" => customer1.id,
  "screening_id" => screening2.id
)

tickets2.save()

tickets3 = Ticket.new(
  "customer_id" => customer2.id,
  "screening_id" => screening3.id
)
tickets3.save()

tickets4 = Ticket.new(
  "customer_id" => customer2.id,
  "screening_id" => screening1.id
)
tickets4.save()

tickets5 = Ticket.new(
  "customer_id" => customer2.id,
  "screening_id" => screening3.id
)
tickets5.save()

tickets6 = Ticket.new(
  "customer_id" => customer1.id,
  "screening_id" => screening2.id
)
tickets6.save()

tickets7 = Ticket.new(
  "customer_id" => customer1.id,
  "screening_id" => screening1.id
)
tickets7.save()

tickets8 = Ticket.new(
  "customer_id" => customer2.id,
  "screening_id" => screening1.id
)
tickets8.save()

tickets9 = Ticket.new(
  "customer_id" => customer2.id,
  "screening_id" => screening2.id
)
tickets9.save(

)
tickets10 = Ticket.new(
  "customer_id" => customer1.id,
  "screening_id" => screening3.id
)
tickets10.save()


binding.pry
nil
