# noinspection RubyUnusedLocalVariable
class Checkout

  STOCKLIST = {A: 50, B: 30, C: 20, D: 15}

  def checkout(skus)
    STOCKLIST[skus.to_sym]
  end

end


