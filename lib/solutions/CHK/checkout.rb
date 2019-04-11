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

  def summarise_order(skus)
    items_array = skus.chars.uniq
    order_summary = {}
    items_array.each do |item|
      order_summary[item.to_sym] = skus.count(item)
    end
    order_summary
  end

  def sum_specials(order_summary)
    @order_after_specials = {}
    @running_total = 0
    order_summary.each do |item, quantity|
      sum_item_special(item, quantity)
      calc_remainder(item, quantity)
    end
    @running_total
  end

  def sum_item_special(item, quantity)
    @running_total += (quantity / SPECIALS_LIST[item][:quant]) * SPECIALS_LIST[item][:price]
  end

  def calc_remainder(item, quantity)
    remainder = quantity % SPECIALS_LIST[item][:quant] if SPECIALS_LIST.key?(item)
    @order_after_specials[item] = remainder unless remainder.nil? || remainder == 0
  end

  attr_reader :order_after_specials, :running_total

  # def sum_specials(skus)
  #   sum = 0
  #   skus.each_char do |item|
  #     SPECIALS_LIST.each do |key, value|
  #        num_bundles = skus.count(item) / value[item.to_sym][:quant])
  #        sum = num_bundles * value[item.to_sym][:price]
  #     end
  #   end
  # end

  # def sum(skus, item, key, value)
  #   num_bundles = skus.count(item) / value[item.to_sym][:quant])
  #   sum = num_bundles * value[item.to_sym][:price]
  # end

end



