require_relative("../db/sqlrunner.rb")

class Customer
  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options_hash)
    @name = options_hash["name"]
    @funds = options_hash["funds"].to_i
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
    updated = SqlRunner.run(sql, values)
  end


  def self.delete_all()
   sql = "DELETE FROM customers"
   values = []
   SqlRunner.run(sql, values)
 end

 def self.map_customers(customer_data)
   customer_data.map{|customer_hash| Customer.new(customer_hash)}
 end

end
