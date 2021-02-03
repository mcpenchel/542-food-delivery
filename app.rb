require_relative "app/repositories/meal_repository" # You need to create this file!
require_relative "app/controllers/meals_controller" # You need to create this file!

require_relative "app/repositories/customer_repository" # You need to create this file!
require_relative "app/controllers/customers_controller" # You need to create this file!

require_relative "app/repositories/employee_repository"
require_relative "app/controllers/sessions_controller"

require_relative "app/repositories/order_repository"
require_relative "app/controllers/orders_controller"

require_relative "router"

CSV_FILE = "data/meals.csv"
repo = MealRepository.new(CSV_FILE)
controller = MealsController.new(repo)

CUSTOMER_CSV_FILE = "data/customers.csv"
customer_repo = CustomerRepository.new(CUSTOMER_CSV_FILE)
customers_controller = CustomersController.new(customer_repo)

EMPLOYEE_CSV_FILE = "data/employees.csv"
employee_repo = EmployeeRepository.new(EMPLOYEE_CSV_FILE)
sessions_controller = SessionsController.new(employee_repo)

ORDER_CSV_FILE = "data/orders.csv"
order_repo = OrderRepository.new(ORDER_CSV_FILE, repo, customer_repo, employee_repo)
orders_controller = OrdersController.new(repo, customer_repo, employee_repo, order_repo)

router = Router.new(controller, customers_controller, sessions_controller, orders_controller)

# Start the app
router.run
