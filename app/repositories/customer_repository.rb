require 'csv' # require is to require a library!
# Examples of libraries that we had to require so far:
# nokogiri, date, open-uri, active-record


# The require_relative is relative to the file you're currently
# at!!
require_relative '../models/customer'

class CustomerRepository

  def initialize(csv_file_path)
    @customers = []
    @csv_file_path = csv_file_path
    load_csv if File.exist?(csv_file_path)
  end

  def all
    @customers
  end

  def create(customer)
    # this is why we needed an accessor for id in the Customer class
    customer.id = @customers.empty? ? 1 : @customers.last.id + 1
    @customers << customer

    save_csv
  end

  def find(id)
    # iterator methods:
    # each, each_with_index, map, select, reject, **find**
    @customers.find do |customer|
      customer.id == id
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
      csv << ['id', 'name', 'address']
      
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
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
      row[:id]    = row[:id].to_i

      @customers << Customer.new(row)
    end
  end

end