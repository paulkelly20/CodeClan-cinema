require("minitest/autorun")
require_relative("../models/customer.rb")
require_relative("../models/films.rb")






class TestCustomer < MiniTest::Test

  def setup()
    @customer1 = Customer.new({"name" => "Paul Kelly", "funds" => 1000})
    @film1 = Film.new({"title" => "Batman", "price" => 20})
    @ticket1 = Ticket.new({"customer_id" => 1, "film_id" => 2})
  end

  def test_customer_wallet()
    assert_equal(1000, @customer1.funds)
  end

  def test_customer_buys_ticket()
    @customer1.customer_purchases_film_ticket(@film1, @ticket1)
    assert_equal(980, @customer1.funds)
    assert_equal(1, @customer1.pocket)
  end

  def test_film_price()
    assert_equal(20, @film1.price)
  end

end
