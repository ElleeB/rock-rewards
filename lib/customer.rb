class Customer

  attr_accessor :email, :purchases, :points, :point_limit, :eligible_to_redeem, :account_id

  @@all = []

  def initialize(email, account_id)
    @email = email
    @purchases = []
    @points = []
    @point_limit = nil
    @eligible_to_redeem = false
    @account_id = account_id
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def client
    Client.find_by_id(self.account_id)
  end

  def self.create(email, account_id)
    new_customer = Customer.new(email, account_id)
    client = Client.find_by_id(account_id)
    new_customer.point_limit = client.customer_point_limit

    new_customer.save

    client.enroll_customer(new_customer)
    new_customer
  end

  def self.find_by_email(email)
    self.all.find { |customer| customer.email == email }
  end

  def total_points
    if self.points.length == 1
      self.points[0]
    elsif self.points.length == 0
      0
    else
      self.points.reduce(:+)
    end
  end

  def add_purchase(amnt)
    # add purchase amnt to array
    self.purchases << amnt
    # update points amnt
    self.points << amnt *= self.client.points_per_dollar
    # check to see if status is false & points at or above 100
    if self.eligible_to_redeem == false && self.points_at_or_above_limit?
      # then update status to true
      self.update_eligible_to_redeem
    else
      nil
    end
    self.display_point_balance
  end

  def points_at_or_above_limit?
    self.total_points >= self.point_limit
  end

  def update_eligible_to_redeem
    self.eligible_to_redeem = true
     puts "Congratulations, you may start redeeming points!"
  end

  def point_limit
    self.client.customer_point_limit
  end

  def redeem_points_request(amnt)
    # if customer has too few points
    if amnt > self.total_points
      puts "Not enough points to redeem".upcase
    # else sends the redeem request
    elsif self.eligible_to_redeem
      self.redeem_points(amnt)
    elsif
      puts "Must accumulate #{self.point_limit} pt(s) before redeeming.".upcase
    end
  end

  def redeem_points(amnt)
    current_redeem_amnt = amnt
    current_point_amnt = self.points[0]

    # while customer has points collected and the redeem amount is not down to 0
     while self.points.length != 0 && current_redeem_amnt != 0
       # if current redeem request is equal to the current array element
      if current_redeem_amnt == current_point_amnt
        current_redeem_amnt = 0
        self.points.delete_at(0)
        self.display_point_balance
      # if current array element is greater than the current redeem request
      elsif current_point_amnt > current_redeem_amnt
        self.points[0] = current_point_amnt - current_redeem_amnt
        current_redeem_amnt = 0
        self.display_point_balance
      # if current array element is less than the current redeem request
      elsif current_point_amnt < current_redeem_amnt
        current_redeem_amnt = current_redeem_amnt - current_point_amnt
        self.points.delete_at(0)
        self.display_point_balance
      end
    end
  end

  def display_point_balance
    "Points Remaining: #{self.total_points}"
  end
end
