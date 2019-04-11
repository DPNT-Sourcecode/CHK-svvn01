# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test

  def test_sum_order
    assert_equal 50, Checkout.new.checkout('A'), 'Calc price of one unit'
  end

  def test_sum_order_2
    assert_equal 30, Checkout.new.checkout('B'), 'Calc price of one unit'
  end

  def test_stock_list
    assert_equal 50, Checkout::STOCK_LIST[:A], 'Check stock list'
  end

  def test_specials_list
    assert_equal 3, Checkout::SPECIALS_LIST[:A][:quant], 'Check specials list'
    assert_equal 130, Checkout::SPECIALS_LIST[:A][:price], 'Check specials list'
  end

  def test_sum_items
    assert_equal 80, Checkout.new.sum_total('AB'), 'Sum total of simple order'
  end

  def test_order_into_hash
    hash = { A: 2, B: 1, C: 1 }
    assert_equal hash, Checkout.new.summarise_order('ABCA'), 'Takes order list and generates hash'
  end

  def test_specials_total
    order_hash = { A: 5, B: 10 }
    assert_equal 355, Checkout.new.sum_specials(order_hash), 'Sums the cost of the items on special'
  end

  # def test_calc_remainder
  #   order_hash = { A: 5 }
  #   order_after_specials = { A: 2 }
  #   assert_equal order_after_specials, Checkout.new.calc_remainder(order_hash), 'Calcs how many items left over after special'
  # end
  #
  # def test_calc_remainder_2
  #   order_hash = { B: 3 }
  #   order_after_specials = { B: 1 }
  #   assert_equal order_after_specials, Checkout.new.calc_remainder(order_hash), 'Calcs how many items left over after special'
  # end



  # def test_item_on_special
  #   assert_equal 130, Checkout.new.sum_special('AAA') 'Check if item and quantity on special'
  # end

  # def test_item_on_special
  #   assert_equal 130, Checkout.new.checkout('AAA') 'Get value of special items'
  # end

end

