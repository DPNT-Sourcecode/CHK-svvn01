# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test

  def test_stock_list
    assert_equal 50, Checkout::STOCK_PRICES[:A], 'Check stock list'
    assert_equal 40, Checkout::STOCK_PRICES[:E], 'Check stock list'
  end

  def test_specials_list
    assert_equal 3, Checkout::SPECIALS_QUANTS[:A], 'Check specials list'
    assert_equal 130, Checkout::SPECIALS_PRICES[:A], 'Check specials list'
    assert_equal 2, Checkout::SPECIALS_QUANTS[:E], 'Check specials list'
    assert_equal -30, Checkout::SPECIALS_PRICES[:E], 'Check specials list'
  end

  def test_calc_total
    skus = 'AAAABBBCCD'
    assert_equal 310, Checkout.new.checkout(skus), 'Calcs total for big order'
  end

  def test_erenous_input
    skus = 'AAaABBBCCD'
    assert_equal -1, Checkout.new.checkout(skus), 'Calcs total for big order'
  end

  def test_calc_E_discount
    skus = 'EEB'
    assert_equal 50, Checkout.new.checkout(skus), 'Calcs discount of free B with 2 Es'
  end
end



