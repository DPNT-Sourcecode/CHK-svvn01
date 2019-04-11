# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

class ClientTest < Minitest::Test

  def test_order
    assert_equal 50, Checkout.new.checkout('A'), 'Calc price of one unit'
  end

end

