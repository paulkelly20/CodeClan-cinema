
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

  # def find_ticket_count_from_screenings()
  #   sql = "SELECT screenings.*, tickets.* FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id WHERE film_id = $1 AND screenings.id = $2"
  #   values = [@film_id,@id]
  #   tickets = SqlRunner.run(sql, values)
  #   result = Ticket.map_tickets(tickets)
  #   result.count
  #
  # end


    # def self.find_ticket_count_from_screenings()
    #   sql = "SELECT screenings.* FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id ;"
    #   values = []
    #   screening_data = SqlRunner.run(sql, values)
    #   result = Screening.map_screenings(screening_data)
    #   result[8]
    #
    # end



     def self.find_ticket_count_from_screenings()
       sql = "SELECT screenings.screening_time, screenings.film_id, count(screenings.screening_time) FROM screenings INNER JOIN tickets ON screenings.id = tickets.screening_id GROUP BY screening_time, film_id ORDER BY screening_time"
       values = []
       screening_data = SqlRunner.run(sql, values)[0]


     end

    def self.map_screenings(screening_data)
      screening_data.map{|screening_hash| Screening.new(screening_hash)}
    end



end
