class Employee
  attr_reader :id, :username, :password

  def initialize(attributes = {})
    @id       = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role     = attributes[:role]
  end

  def manager?
    @role == "manager"
  end

  def rider?
    @role == "rider"
  end
end

# milene = Employee.new(
#   id: 1,
#   username: "milene",
#   password: "koreandrama",
#   role: "manager"
# )

# matt = Employee.new(
#   id: 2,
#   username: "matt",
#   password: "mastodon",
#   role: "rider"
# )
