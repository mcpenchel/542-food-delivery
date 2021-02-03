class Customer
  attr_reader :name, :address
  attr_accessor :id # attr_reader + attr_writer

  def initialize(attributes = {})
    @id    = attributes[:id]
    @name  = attributes[:name]
    @address = attributes[:address]
  end
end
