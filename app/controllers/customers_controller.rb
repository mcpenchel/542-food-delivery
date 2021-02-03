require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repository)
    @repo = customer_repository
    @view = CustomerView.new
  end

  def add
    name = @view.ask_for_name
    address = @view.ask_for_address
    new_customer = Customer.new(name: name, address: address)
    @repo.create(new_customer)
  end

  def list
    customers = @repo.all
    @view.display_all(customers)
  end
end
