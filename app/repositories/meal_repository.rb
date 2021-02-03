require 'csv'
require_relative '../models/meal'

class MealRepository
  LOAD_CSV_OPTIONS = {
    col_sep: ',',
    quote_char: '"',
    headers: :first_row,
    header_converters: :symbol
  }

  def initialize(csv_file_path)
    @meals = []
    @csv_file_path = csv_file_path
    load_csv if File.exist?(csv_file_path)
  end

  def all
    @meals
  end

  def create(meal)
    meal.id = @meals.empty? ? 1 : @meals.last.id + 1
    @meals << meal

    save_csv
  end

  def find(id)
    @meals.find do |meal|
      meal.id == id
    end
  end

  private

  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'price']

      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, LOAD_CSV_OPTIONS) do |row|
      row[:id]    = row[:id].to_i
      row[:price] = row[:price].to_i

      @meals << Meal.new(row)
    end
  end
end
