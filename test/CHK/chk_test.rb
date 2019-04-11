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

end





