# noinspection RubyUnusedLocalVariable
class Checkout

  STOCK_PRICES = {
    A: 50,
    B: 30,
    C: 20,
    D: 15,
    E: 40,
    F: 10,
    G: 20,
    H: 10,
    I: 35,
    J: 60,
    K: 70,
    L: 90,
    M: 15,
    N: 40,
    O: 10,
    P: 50,
    Q: 30,
    R: 50,
    S: 20,
    T: 20,
    U: 40,
    V: 50,
    W: 20,
    X: 17,
    Y: 20,
    Z: 21 }

  SPECIALS_QUANTS = {
    A: 5,
    B: 2,
    F: 3,
    H: 10,
    K: 2,
    P: 5,
    Q: 3,
    U: 4,
    V: 3 }

  SPECIALS_PRICES = {
    A: 200,
    B: 45,
    F: 20,
    H: 80,
    K: 120,
    P: 200,
    Q: 80,
    U: 120,
    V: 130 }

  SPECIALS_QUANTS_2 = {
    A: 3,
    H: 5,
    V: 2 }

  SPECIALS_PRICES_2 = {
    A: 130,
    H: 45,
    V: 90 }

  GROUP = [:X, :Y, :T, :S, :Z]

  def checkout(skus)
    return -1 if check_skus(skus) == false
    @running_total = 0
    order = summarise_order(skus)
    specials_summary = {}
    specials_summary_2 = {}
    remove_items_on_bogof(order)
    update_order_for_groups(order)
    update_order_for_specials(order, specials_summary, SPECIALS_QUANTS)
    update_order_for_specials(order, specials_summary_2, SPECIALS_QUANTS_2)
    sum(order, STOCK_PRICES)
    sum(specials_summary, SPECIALS_PRICES)
    sum(specials_summary_2, SPECIALS_PRICES_2)
    @running_total
  end

  # private

  def check_skus(skus)
    skus.each_char do |item_string|
      return false unless STOCK_PRICES.key?(item_string.to_sym)
    end
  end

  def summarise_order(skus)
    order = {}
    items_array = skus.chars.uniq
    items_array.each do |item|
      order[item.to_sym] = skus.count(item)
    end
    order
  end

  def update_order_for_specials(order, specials_summary, quant_list)
    order.each do |item, quantity|
      add_items_on_special(specials_summary, item, quantity, quant_list)
      remove_items_on_special(order, item, quantity, quant_list)
    end
    order
  end

  def sum(order, price_list)
    order.each do |item, quantity|
      @running_total += order[item] * price_list[item]
    end
  end

  def remove_items_on_bogof(order)
    order[:B] -= order[:E] / 2 if order.key?(:B) && order.key?(:E)
    order[:M] -= order[:N] / 3 if order.key?(:M) && order.key?(:N)
    order[:Q] -= order[:R] / 3 if order.key?(:Q) && order.key?(:R)
  end

  def add_items_on_special(specials_summary, item, quantity, quant_list)
    item_quantity = quantity / quant_list[item] if quant_list.key?(item)
    specials_summary[item] = item_quantity unless item_quantity == 0 || item_quantity.nil?
  end

  def remove_items_on_special(order, item, quantity, quant_list)
    remainder = quantity % quant_list[item] if quant_list.key?(item)
    order[item] = remainder unless remainder.nil?
  end

  def update_order_for_groups(order)
    group_items = 0
    GROUP.each do |item|
      group_items += order[item] if order.key?(item)
    end
    groups_quantity = group_items / 3
    @running_total += groups_quantity * 45
p order
    GROUP.each do |item|
p item
      remove_group_items(order, group_items, item) if order.key?(item)
p order
    end
p order
  end

  def remove_group_items(order, group_items, item)
    groups_remainder = group_items % 3
    item_quantity = order[item]
    order[item] = groups_remainder if groups_remainder <= order[item]
    order[item] = 0 if groups_remainder > order[item]
    groups_remainder -= item_quantity - order[item]
  end
end

