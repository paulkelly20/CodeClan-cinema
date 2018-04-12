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

  def self.delete_all()
   sql = "DELETE FROM films"
   values = []
   SqlRunner.run(sql, values)
 end

 def self.map_films(film_data)
   film_data.map{|film_hash| Film.new(film_hash)}
 end

end
