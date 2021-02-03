class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts "Welcome to the Food Delivery App!"
    puts "           --           "

    while @running
      # The code will only exit from the sign_in method if
      # the user manages to sign_in correctly.
      @current_user = @sessions_controller.sign_in
      while @current_user
        if @current_user.manager?
          display_manager_tasks
          action = gets.chomp.to_i
          print `clear`
          route_manager_action(action)
        else
          display_rider_tasks
          action = gets.chomp.to_i
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  private

  def route_rider_action(action)
    case action
    when 1 then puts "TO-DO: Mark one order as delivered"
    when 2 then puts "TO-DO: List all undelivered orders"
    when 3 then sign_out
    when 4 then stop
    else
      puts "Please choose 1, 2 or 3"
    end
  end

  def route_manager_action(action)
    case action
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 5 then puts "TO-DO: Create an order"
    when 6 then puts "TO-DO: List all orders"
    when 7 then sign_out
    when 8 then stop
    else
      puts "Please press 1, 2, 3, 4, 5, 6 or 7"
    end
  end

  def sign_out
    @current_user = nil
  end

  def stop
    sign_out
    @running = false
  end

  def display_manager_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - Add a new Meal"
    puts "2 - List all the Meals"
    puts "3 - Add a new Customer"
    puts "4 - List all the Customers"
    puts "5 - Add a new order"
    puts "6 - List all orders"
    puts "7 - Sign out"
    puts "8 - Stop and exit the program"
    print "> "
  end

  def display_rider_tasks
    puts ""
    puts "What do you want to do next?"
    puts "1 - Mark one of my orders as delivered"
    puts "2 - List all my undelivered orders"
    puts "3 - Sign out"
    puts "4 - Stop and exit the program"
    print "> "
  end
end
