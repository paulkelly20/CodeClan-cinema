
require_relative("../db/sqlrunner")


class Ticket
  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options_hash)
    @customer_id = options_hash["customer_id"].to_i
    @film_id = options_hash["film_id"].to_i
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values).first
    @id = ticket["id"].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    values = []
    result = SqlRunner.run(sql, values)
    tickets = result.map {|ticket_hash|Ticket.new(ticket_hash)}
  end

  def self.delete_all()
   sql = "DELETE FROM tickets"
   values = []
   SqlRunner.run(sql, values)
 end


end
