require_relative("../db/sqlrunner")
class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options_hash)
    @title = options_hash["title"]
    @price = options_hash["price"].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id;"
    values = [@title, @price]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.*, films.*, tickets.*, screenings.* FROM films INNER JOIN screenings ON films.id = screenings.film_id INNER JOIN tickets ON screenings.id = tickets.screening_id INNER JOIN customers ON customers.id = tickets.customer_id  WHERE tickets.screening_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Customer.map_customers(films)
    return result
  end

  def self.map_films(film_data)
    film_data.map{|film_hash| Film.new(film_hash)}
  end

  def customers_count
    return customers.count
  end
end
