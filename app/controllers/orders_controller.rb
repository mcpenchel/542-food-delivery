require_relative '../views/orders_view'
require_relative '../models/order'

# OrdersController
#   should be initialized with 4 repository instances (FAILED - 2)
#   #add
#     should ask the user for a meal index, a customer index and an employee index to be assigned (FAILED - 3)
#   #list_undelivered_orders
#     should list undelivered orders (with meal, employee assigned and customer info) (FAILED - 4)
#   #list_my_orders
#     should take an Employee instance as a parameter (FAILED - 5)
#     should list Ringo's undelivered orders (FAILED - 6)
#   #mark_as_delivered
#     should take an Employee instance as a parameter (FAILED - 7)
#     should ask the rider for an order index (of their undelivered orders), mark it as delivered, and save the relevant data to the CSV file (FAILED - 8)

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @view = OrdersView.new
  end

  def add
    # Display all meals with index + 1
    meal_index = @view.ask_for_index("meal")
    # Display all customers with index + 1
    customer_index = @view.ask_for_index("customer")
    # Display all employees with index + 1
    employee_index = @view.ask_for_index("employee")

    meal = @meal_repository.all[meal_index]
    customer = @customer_repository.all[customer_index]
    employee = @employee_repository.all_riders[employee_index]

    order = Order.new(meal: meal, customer: customer, employee: employee)
    # inside the initialize method of the Order class,
    # attribus will be that!!
    @order_repository.create(order)
  end

  def list_undelivered_orders
    orders = @order_repository.undelivered_orders

    @view.display_all(orders)
  end

  def list_my_orders(employee)
    orders = @order_repository.undelivered_orders

    employee_orders = orders.select do |order|
      order.employee == employee
    end

    @view.display_all(employee_orders)
  end

  def mark_as_delivered(employee)
    # Display to the user all the undelivered orders with index +1
    order_index = @view.ask_for_index("order")
    orders = @order_repository.undelivered_orders

    employee_orders = orders.select do |order|
      order.employee == employee
    end
    
    order = employee_orders[order_index]

    @order_repository.mark_as_delivered(order)
  end
end