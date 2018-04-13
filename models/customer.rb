require_relative("../db/sqlrunner.rb")
require_relative("films.rb")
require_relative("ticket.rb")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options_hash)
    @name = options_hash["name"]
    @funds = options_hash["funds"].to_i
    @pocket = []
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id;"
    values = [@name, @funds]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result_hash = Customer.map_customers(customers)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end


  def films()
    sql = "SELECT customers.*, films.*, tickets.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id INNER JOIN films ON films.id = tickets.film_id WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films)
    return result
  end


  def delete()
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.map_customers(customer_data)
    customer_data.map{|customer_hash| Customer.new(customer_hash)}
  end

  def pocket()
    return @pocket.count
  end

  def customer_purchases_film_ticket(film, ticket)
    if @funds > film.price
      @funds -= film.price
      @pocket << ticket
    else "Too poor"
    end
  end

  def films_count()
    return films.count()
  end

end
