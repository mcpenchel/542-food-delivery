require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []

    load_csv if File.exist?(csv_file_path)
  end

  def all_riders
    @employees.select do |employee|
      employee.rider?
    end
  end

  def find_by_id(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def find_by_username(username)
    @employees.find do |employee|
      employee.username == username
    end
  end

  private

  def load_csv
    csv_options = {
      col_sep: ',',
      quote_char: '"',
      headers: :first_row,
      header_converters: :symbol
    }

    CSV.foreach(@csv_file_path, csv_options) do |row|
      row[:id] = row[:id].to_i

      @employees << Employee.new(row)
    end
  end
end

# repo = EmployeeRepository.new('data/employees.csv')
# p repo.all_riders

# p repo.find_by_id(1)
# p repo.find_by_username("matt")
