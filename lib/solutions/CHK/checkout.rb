# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_PRICES = { A: 50, B: 30, C: 20, D: 15 }
  SPECIALS_QUANTS = { A: 3, B: 2 }
  SPECIALS_PRICES = { A: 130 , B: 45 }

  def checkout(skus)
    return -1 if check_skus(skus) == false
    @running_total = 0
    sum_normals(sum_specials(summarise_order(skus)))
    @running_total
  end

  private

  def check_skus(skus)
    skus.each_char do |item|
      return false unless STOCK_PRICES.key?(item.to_sym)
    end
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
    @special_order_summary = {}
    order_summary.each do |item, quantity|
      take_specials_off_order(order_summary, item, quantity)
      add_specials_to_order(order_summary, item, quantity)
    end
    order_summary
  end

  def sum_normals(order_after_specials)
    order_after_specials.each do |item, quantity|
      add_items(order_after_specials, item, quantity, STOCK_PRICES)
    end
  end

  def add_items(order_summary, item, quantity, price_list)
    @running_total += order_summary[item] * price_list[item] if price_list.key?(item)
  end

  def take_specials_off_order(order_summary, item, quantity)
    remainder = quantity % SPECIALS_QUANTS[item] if SPECIALS_PRICES.key?(item)
    order_summary[item] = remainder unless remainder.nil?
  end

  def add_specials_to_order(order_summary, item, quantity)
    @special_order_summary[item_special] = quant_specials(item, quantity)
  end

  def quant_specials(item, quantity)
    quantity / SPECIALS_QUANTS[item]
  end
end



