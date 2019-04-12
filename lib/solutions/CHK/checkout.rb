# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_PRICES = { A: 50, B: 30, C: 20, D: 15, E: 40 }
  SPECIALS_QUANTS = { A: 5, B: 2 }
  SPECIALS_PRICES = { A: 200, B: 45 }
  SPECIALS_QUANTS_2 = { A: 3 }
  SPECIALS_PRICES_2 = { A: 130 }

  def checkout(skus)
    return -1 if check_skus(skus) == false
    @running_total = 0
    @specials_summary = {}
    sum(update_order_for_specials(summarise_order(skus)), STOCK_PRICES)
# call update_order_for_specials twice, once with each stock list/price list
    sum(@specials_summary, SPECIALS_PRICES)
# need to work out how you sum the lists with different price lists
    @running_total
  end

  # private

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

  def update_order_for_specials(order_summary) # price list arg goes into add_items_on_special
# here would need to go round twice with both specials lists
    remove_items_on_bogof(order_summary)
    order_summary.each do |item, quantity|
p 'item...'
p item
      add_items_on_special(@specials_summary, item, quantity, SPECIALS_PRICES)
      remove_items_on_special(order_summary, item, quantity)
    end
    order_summary
  end

  def sum(order_summary, price_list)
    order_summary.each do |item, quantity|
p 'quantity item...'
      @running_total += order_summary[item] * price_list[item] if price_list.key?(item)
p 'running total...'
p @running_total
    end
  end

  def remove_items_on_bogof(order_summary)
    if order_summary.key?(:B) && order_summary.key?(:E)
      order_summary[:B] -= order_summary[:E] / 2
    end
  end

  def add_items_on_special(specials_summary, item, quantity, price_list)
    item_quantity = quantity / SPECIALS_QUANTS[item] if price_list.key?(item)
    specials_summary[item] = item_quantity unless item_quantity == 0 || item_quantity.nil?
p 'specials summary...'
p specials_summary
  end

  def remove_items_on_special(order_summary, item, quantity)
    remainder = quantity % SPECIALS_QUANTS[item] if SPECIALS_PRICES.key?(item)
p 'remainder...'
p remainder
    order_summary[item] = remainder unless remainder.nil?
  end
end







