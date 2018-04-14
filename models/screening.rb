require_relative("../db/sqlrunner")

class Screening

  attr_reader :id

  attr_accessor :screening_time, :film_id, :capacity

  def initialize(options_hash)
    @screening_time = options_hash["screening_time"]
    @film_id = options_hash["film_id"].to_i
    @capacity = options_hash["capacity"].to_i

  end

  def save()
    sql = "INSERT INTO screenings (screening_time, film_id, capacity) VALUES ($1, $2, $3) RETURNING id;"
    values = [@screening_time, @film_id, @capacity]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    result = SqlRunner.run(sql, values)
    screenings = result.map {|screening_hash|Screening.new(screening_hash)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    values = []
    SqlRunner.run(sql, values)
  end

  def self.find_ticket_count_from_screenings()
    sql = "SELECT screenings.screening_time, screenings.film_id, count(screenings.screening_time) FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id GROUP BY screening_time, film_id ORDER BY screening_time"
    values = []
    screening_data = SqlRunner.run(sql, values)[0]
  end

  def self.map_screenings(screening_data)
    screening_data.map{|screening_hash| Screening.new(screening_hash)}
  end

end
