require "spec_helper"

describe Client do
  describe "#client_registration" do
    it "takes a name argument for the new client and auto assigns account_id and secret_key" do
      new_client = Client.create("My Company Name")

      new_client_name = new_client.instance_variable_get(:@name)
      new_client_account_id = new_client.instance_variable_get(:@account_id)
      new_client_secret_key = new_client.instance_variable_get(:@secret_key)

      expect(new_client_name).to eq("My Company Name")
      expect(new_client_account_id).to be_a Integer
      expect(new_client_secret_key).to be_a String
    end
  end
end

describe Customer do
  describe "#customer_enroll" do
    it "accepts an email and account_id for the new customer" do
      new_client = Client.create("My Company Name")
      new_customer = Customer.create("sam@email.com", new_client.account_id)

      new_customer_email = new_customer.instance_variable_get(:@email)
      new_customer_account_id = new_customer.instance_variable_get(:@account_id)

      expect(new_customer_email).to eq("sam@email.com")
      expect(new_customer_account_id).to eq(new_client.account_id)
    end
  end
end

describe RockingRewardsController do
  new_client = Client.create("My Company Name")
  let(:customer) { Customer.create("sally@email.com", new_client.account_id) }

  before(:each) do
    customer.add_purchase(90)
    customer.add_purchase(30)
  end

  describe "#customer_purchase" do
    it "updates customer point amount based on purchase amount" do
      total_points = customer.total_points

      expect(total_points).to eq(120)
    end
  end

  describe "#customer_redemption" do
    it "updates customer's total points after redeeming" do
      customer.redeem_points_request(90)

      expect(customer.total_points).to eq(30)
    end

    it "displays customers' total points after redeeming" do
      customer.redeem_points_request(90)

      expect(customer.display_point_balance).to eq("Points Remaining: 30")
    end
  end
end
