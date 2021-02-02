class Meal

  # def initialize(id, name, price) => this is bad, old style
  attr_reader :name, :price
  attr_accessor :id # attr_reader + attr_writer

  def initialize(attributes = {})
    @id    = attributes[:id]
    @name  = attributes[:name]
    @price = attributes[:price]
  end

end

# lunch = Meal.new(id: 1, name: "Fitness Rice with Carrot", price: 26)

# p lunch.id
# p lunch.name
# p lunch.price

# lunch.id = 15


# def upcase(str)
#   str.upcase # when it's line 28, it's 'mastodon'; 29, 'lion'
# end

# upcase("mastodon")
# upcase("lion")
# upcase("velasco")