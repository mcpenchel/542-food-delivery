require 'csv'
require 'byebug'

class OrderRepository

  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @orders_csv_path = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository

    @orders = []

    load_csv if File.exist?(orders_csv_path)
  end

  def create(order) # the controller will send me this order instance
    order.id = @orders.empty? ? 1 : @orders.last.id + 1
    @orders << order

    save_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def mark_as_delivered(order)
    order.deliver!

    save_csv
  end

  private
  def save_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }

    CSV.open(@orders_csv_path, 'wb', csv_options) do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']

      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
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

    CSV.foreach(@orders_csv_path, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == "true"

      # byebug (continue tells ruby to move forward, exit to exit)

      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)

      @orders << Order.new(row)
    end
  end

end