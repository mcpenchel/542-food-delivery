require_relative "app/repositories/meal_repository" # You need to create this file!
require_relative "app/controllers/meals_controller" # You need to create this file!

require_relative "app/repositories/customer_repository" # You need to create this file!
require_relative "app/controllers/customers_controller" # You need to create this file!

require_relative "router"

CSV_FILE = "data/meals.csv"
repo = MealRepository.new(CSV_FILE)
controller = MealsController.new(repo)

CUSTOMER_CSV_FILE = "data/customers.csv"
customer_repo = CustomerRepository.new(CUSTOMER_CSV_FILE)
customers_controller = CustomersController.new(customer_repo)

router = Router.new(controller, customers_controller)

# Start the app
router.run
