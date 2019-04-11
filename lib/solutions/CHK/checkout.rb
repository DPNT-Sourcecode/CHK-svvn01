# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_LIST = {A: 50, B: 30, C: 20, D: 15}

  def checkout(skus)
    STOCK_LIST[skus.to_sym]
  end

end



