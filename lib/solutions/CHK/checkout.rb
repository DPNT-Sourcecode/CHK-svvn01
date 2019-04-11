# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_LIST = { A: 50, B: 30, C: 20, D: 15 }
  SPECIALS_LIST = { A: {quant: 3, price: 130 }, B: {quant: 2, price: 45 } }

  def checkout(skus)
    STOCK_LIST[skus.to_sym]
  end

  def sum_total(skus)
    sum = 0
    skus.each_char do |item|
      STOCK_LIST.each do |key, value|
        sum += value if item.to_sym == key
      end
    end
   sum
  end

  def num_specials(skus)
    skus.each_char do |item|
      SPECIALS_LIST.each do |key, value|
        (skus.count(item) / value[item.to_sym][:quant]) * value[item.to_sym][:price]
      end
    end
  end

end





