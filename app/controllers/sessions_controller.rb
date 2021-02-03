require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @repo = employee_repository
    @view = SessionsView.new
  end

  def sign_in
    # 1) Ask the user for username and store that value
    username = @view.ask_for("username")
    # 2) Ask the user for password and store that value
    password = @view.ask_for("password")

    # 3) If the username and password matches,
    #    we return the employee instance..
    employee = @repo.find_by_username(username)

    if employee && employee.password == password
      @view.welcome(employee)
      return employee # even in a recursive call, return exists the method!
    else
      # 4) Else, we repeate steps 1, 2 and 3
      @view.wrong_credentials
      # Recursive Call
      sign_in
    end
  end
end
