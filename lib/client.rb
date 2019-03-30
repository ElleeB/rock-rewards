class Client
  include App

  attr_accessor :name, :customers, :points_per_dollar, :customer_point_limit,
                :account_id, :secret_key
  @@all = []

  def initialize(name)
    @name = name
    @customers = []
    @points_per_dollar = 1
    @customer_point_limit = 0
    @account_id = self.assign_client_id
    @secret_key = nil
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  def self.create(name)
    new_client = Client.new(name)
    new_client.assign_key
    new_client.save
    new_client
  end

  def self.find_by_id(id)
    self.all.find { |client| client.account_id == id}
  end

  def set_points_per_dollar(point_amnt)
    self.points_per_dollar = point_amnt
  end

  def set_customer_redemption_limit(num_of_points)
    self.customer_point_limit = num_of_points
    # update all customer limits
    self.customers.each do |customer|
      customer.point_limit = self.customer_point_limit
    end
  end

  def enroll_customer(customer)
    self.customers << customer
  end
end
