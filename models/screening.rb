
require_relative("../db/sqlrunner")

class Screening

  attr_reader :id

  attr_accessor :screening_time, :film_id

  def initialize(options_hash)
    @screening_time = options_hash["screening_time"]
    @film_id = options_hash["film_id"].to_i

  end

  def save()
    sql = "INSERT INTO screenings (screening_time, film_id) VALUES ($1, $2) RETURNING id;"
    values = [@screening_time, @film_id]
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



end
