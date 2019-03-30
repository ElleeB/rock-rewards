class RockingRewardsController

  def initialize
    @current_client = nil
  end

  def call
    puts "Welcome to Rocking Rewards!"
    input = nil

    register
  end

  def cli_commands(i)
    if i == 'e'
      enroll
    elsif i == 'all'
      view_all_customers
    elsif i == 'p'
      record_purchase
    elsif i == 're'
      redeem_points
    elsif i == 'l'
      set_limit
    elsif i == 'per'
      set_points_per_dollar
    elsif i == 'o'
      options
    elsif i == 'exit'
      exit
    else
      puts "Please enter one of the above options"
    end
  end

  def register
    puts "To register, please enter your organization's name"

    i = gets.strip
    client = Client.create(i)

    puts "Welcome, #{client.name}!"
    puts "Your secret key is: #{client.secret_key}."

    @current_client = client

    options
    i = gets.strip
    cli_commands(i)
  end

  def enroll
    hr
    puts "Please enter new customer's Email address"

    i = gets.strip
    customer = Customer.create(i, @current_client.account_id)
    hr
    puts "New customer enrolled - Account: #{customer.account_id} - Email: #{customer.email}"
    options

    i = gets.strip
    cli_commands(i)
  end

  def options
    hr
    puts "Complete steps 1-3 before steps 4-6"
    hr
    puts "1. To set redemption point limit, enter 'l'"
    puts "2. To set points-per-dollar amount, enter 'per'"
    puts "3. To enroll a new customer, enter 'e'"
    hr
    puts "4. To view all customers, enter 'all'"
    puts "5. To record a customer purchase, enter 'p'"
    puts "6. To redeem customer points, enter 're'"

    i = gets.strip
    cli_commands(i)
  end

  def view_all_customers
    hr
    @current_client.customers.each { |customer| puts "Customer: - Account: #{customer.account_id} - Email: #{customer.email} - Total Points: #{customer.total_points}"}

    options
    i = gets.strip
    cli_commands(i)
  end

  def record_purchase
    hr
    puts "Please enter the customer email"
    i = gets.strip

    if customer = Customer.find_by_email(i)
      puts "Please enter the purchase ammount"
      i = gets.strip
      amnt = i.to_i
      customer.add_purchase(amnt)
      hr
      puts "Customer: - Account: #{customer.account_id} - Email: #{customer.email} - Purchase: $#{amnt}"
      hr
      puts "Customer total points: #{customer.total_points}"
      options
    else
      puts "Please enter an existing user's email"
      record_purchase
    end
  end

  def redeem_points
    hr
    puts "Please enter the customer email"
    i = gets.strip

    if customer = Customer.find_by_email(i)
      puts "Please enter the amount to redeem"
      i = gets.strip
      amnt = i.to_i
      customer.redeem_points_request(amnt)
      hr
      puts "Customer total points: #{customer.total_points}"
      options
    else
      puts "Please enter an existing user's email"
      redeem_points
    end
  end

  def set_limit
    puts "Please enter the amount of points a customer must reach before redeeming"
    i = gets.strip
    amnt = i.to_i
    @current_client.set_customer_redemption_limit(amnt)
    hr
    puts "Customer redemption limit set to #{amnt}."
    options
  end

  def set_points_per_dollar
    puts "Please enter the amount of points you'd like to award per dollar"
    puts ("Default: 1 point per dollar")
    i = gets.strip
    amnt = i.to_i
    @current_client.set_points_per_dollar(amnt)
    hr
    puts "Reward points set to #{amnt} point(s) per dollar."
    options
  end

  def hr
    puts "-----------------------------------"
  end
end
