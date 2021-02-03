class OrdersView

  def ask_for_index(order_item)
    puts "What's the index of the #{order_item}?"
    print ">"
    gets.chomp.to_i - 1
  end

  # When we display the indexes of the items, we will do it with + 1
  def display_all(orders)
    orders.each do |order|
      puts "#{order.id}: #{order.meal.name} for #{order.customer.name}, to be delivered by #{order.employee.username}"
    end
  end

end