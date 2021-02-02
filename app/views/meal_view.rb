class MealView

  def ask_for_name
    puts "What's the name?"
    gets.chomp
  end

  def ask_for_price
    puts "What's the price?"
    gets.chomp.to_i
  end

  def display_all(meals_array)
    meals_array.each do |meal|
      puts "#{meal.id}: #{meal.name} (#{meal.price} BRL)"
    end
  end

end