require 'csv' # require is to require a library!
# Examples of libraries that we had to require so far:
# nokogiri, date, open-uri, active-record


# The require_relative is relative to the file you're currently
# at!!
require_relative '../models/meal'

class MealRepository

  def initialize(csv_file_path) # "data/meals.csv"
    @meals = []
    @csv_file_path = csv_file_path
    load_csv if File.exist?(csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    # this is why we needed an accessor for id in the Meal class
    meal.id = @meals.empty? ? 1 : @meals.last.id + 1
    @meals << meal

    save_csv
  end

  def find(id)
    # iterator methods:
    # each, each_with_index, map, select, reject, **find**
    @meals.find do |meal|
      meal.id == id
    end
  end

  private
  # Other files, outside of this class, don't need to know
  # about the load_csv method.
  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    
    # wb -> "write from beginning" => erases the file
    #                                 and write it from scratch
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']
      
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    csv_options = {
      col_sep: ',',
      quote_char: '"',
      headers: :first_row,
      header_converters: :symbol
    }
    
    CSV.foreach(@csv_file_path, csv_options) do |row|
      # without those two options,
      # row is: ["id","name","price"]
      # with the first option (headers: :first_row),
      # row is: {"id" => "1","name" => "Margherita","price" => "8"}
      # with all the options,
      # row is: {id: "1", name: "Margherita", price: "8"}
      row[:id]    = row[:id].to_i
      row[:price] = row[:price].to_i

      @meals << Meal.new(row)
    end
  end

end

# This is the path from where I'm currently at in the terminal!
# repo = MealRepository.new("data/meals.csv")
# p repo

# meal = Meal.new(name: "Salad", price: 30)

# repo.create(meal)