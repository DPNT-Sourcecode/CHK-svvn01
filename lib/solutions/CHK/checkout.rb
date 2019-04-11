# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_PRICES = { A: 50, B: 30, C: 20, D: 15 }
  SPECIALS_QUANTS = { A: 3, B: 2 }
  SPECIALS_PRICES = { A: 130 , B: 45 }

  def checkout(skus)
  p summarise_order(skus)
  p sum_specials(summarise_order(skus))
  p sum_normals(sum_specials(summarise_order(skus)))
    sum_normals(sum_specials(summarise_order(skus)))
  end

  def summarise_order(skus)
    order_summary = {}
    items_array = skus.chars.uniq
    items_array.each do |item|
      order_summary[item.to_sym] = skus.count(item)
    end
    order_summary
  end

  def sum_specials(order_summary)
    order_after_specials = order_summary
    @running_total = 0
    order_summary.each do |item, quantity|
      add_special_items(item, quantity)
      calc_remainder(item, quantity)
    end
    order_after_specials
  end

  def sum_normals(order_after_specials)
    order_after_specials.each do |item, quantity|
      add_normal_items(item, quantity)
    end
  end

  def add_special_items(item, quantity)
    @running_total += quant_specials(item, quantity) * SPECIALS_PRICES[item] if SPECIALS_PRICES.key?(item)
  end

  def add_normal_items(order_after_specials, item, quantity)
    @running_total += order_after_specials[item] * STOCK_PRICES[item]
  end

  def calc_remainder(item, quantity)
    remainder = quantity % SPECIALS_QUANTS[item] if SPECIALS_PRICES.key?(item)
    @order_after_specials[item] = remainder unless remainder.nil?
  end

  def quant_specials(item, quantity)
    quantity / SPECIALS_QUANTS[item]
  end
end




