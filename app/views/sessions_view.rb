class SessionsView
  def ask_for(field)
    puts "#{field}?"
    puts ">"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials.. Try again!"
  end

  def welcome(employee)
    puts "Welcome, #{employee.username}"
  end
end
