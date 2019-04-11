# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_PRICES = { A: 50, B: 30, C: 20, D: 15 }
  SPECIALS_QUANTS = { A: 3, B: 2 }
  SPECIALS_PRICES = { A: 130 , B: 45 }


  def checkout(skus)
    STOCK_PRICES[skus.to_sym]
  end

  def sum_total(skus)
    sum = 0
    skus.each_char do |item|
      STOCK_PRICES.each do |key, value|
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
    @order_after_specials = order_summary
    @running_total = 0
    order_summary.each do |item, quantity|
      add_special_items(item, quantity)
      calc_remainder(item, quantity)
    end
    @running_total
  end

  def sum_normals
    @order_after_specials.each do |item, quantity|
      add_normal_items(item, quantity)
    end
  end

  def add_special_items(item, quantity)
    @running_total += quant_specials(item, quantity) * SPECIALS_PRICES[item] if SPECIALS_PRICES.key?(item)
  end

  def add_normal_items(item, quantity)
    @running_total += @order_after_specials[item] * STOCK_PRICES[item]
  end

  def calc_remainder(item, quantity)
    remainder = quantity % SPECIALS_QUANTS[item] if SPECIALS_PRICES.key?(item)
    @order_after_specials[item] = remainder unless remainder.nil?
  end

  def quant_specials(item, quantity)
    quantity / SPECIALS_QUANTS[item]
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



