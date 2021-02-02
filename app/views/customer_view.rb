class CustomerView

  def ask_for_name
    puts "What's the name?"
    gets.chomp
  end

  def ask_for_address
    puts "What's the address?"
    gets.chomp
  end

  def display_all(customers_array)
    customers_array.each do |customer|
      puts "#{customer.id}: #{customer.name} (living at #{customer.address})"
    end
  end

end