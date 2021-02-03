require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @repo = meal_repository
    @view = MealView.new
  end

  def add
    # should ask the user for a name and price,
    # then store the new meal

    # 1) ask user for the name (puts / gets.chomp)
    #   1.1) store it into a variable
    name = @view.ask_for_name
    # 2) repeat step 1 and 1.1 for price
    price = @view.ask_for_price
    # 3) Build a meal instance (Meal.new)
    new_meal = Meal.new(name: name, price: price)
    # 4) send that meal instance to @repo.create
    @repo.create(new_meal)
  end

  def list
    # 1) Fetch from the repo the array of meals (method .all)
    #   1.1) store that into a variable
    meals = @repo.all
    # 2) Send it to the view, so that the view can display it
    @view.display_all(meals)
  end
end
