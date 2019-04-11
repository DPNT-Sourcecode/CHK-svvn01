# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test

  def test_stock_list
    assert_equal 50, Checkout::STOCK_PRICES[:A], 'Check stock list'
  end

  def test_specials_list
    assert_equal 3, Checkout::SPECIALS_QUANTS[:A], 'Check specials list'
    assert_equal 130, Checkout::SPECIALS_PRICES[:A], 'Check specials list'
  end

  def test_order_into_hash
    hash = { A: 2, B: 1, C: 1 }
    assert_equal hash, Checkout.new.summarise_order('ABCA'), 'Takes order list and generates hash'
  end

  def test_specials_total
    order_hash = { A: 5, B: 10 }
    assert_equal 355, Checkout.new.sum_specials(order_hash), 'Sums the cost of the items on special'
  end

  def test_calc_remainder
    order_hash = { A: 5, B: 10, C: 2 }
    order_after_specials = { A: 2, B: 0, C: 2 }
    c = Checkout.new
    c.sum_specials(order_hash)
    assert_equal order_after_specials, c.order_after_specials, 'Calcs how many items left over after special'
  end

  def test_calc_total
    skus = 'AAAABBBCCD'
    assert_equal 310, Checkout.new.checkout(skus), 'Calcs total for big order'
  end


end



