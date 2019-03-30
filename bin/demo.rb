#!/usr/bin/env ruby

require_relative '../config/environment'

def hr
  puts "-----------------------------------"
end

# add new client1
clientOne = Client.create("Really Exciting Adventures")
hr
puts "Welcome, #{clientOne.name}. Your account number is #{clientOne.account_id}"
puts "Your super secret key is, #{clientOne.secret_key}. Don't forget and never reveal!"
hr
puts "SETTING POINTS PER DOLLAR................................"
clientOne.points_per_dollar = 1
puts "You have set your points per dollar amount to #{clientOne.points_per_dollar} point(s) per dollar"
hr
puts "SETTING REDEMPTION LIMIT................................"
clientOne.customer_point_limit = 100
puts "You have set your customer redemption points limit to #{clientOne.customer_point_limit}"
hr
#  add new customer1
puts "ADDING NEW REWARDS CUSTOMER................................"
customerOne = Customer.create("petunia@email.com", clientOne.account_id)
puts "New customer Email: #{customerOne.email} | Account Id: #{customerOne.account_id} | #{customerOne.display_point_balance}"
hr
puts "PETUNIA MAKES A $90 PURCHASE................................"
customerOne.add_purchase(90)
puts customerOne.display_point_balance
hr
puts "PETUNIA ATTEMPTS TO REDEEM 20 pts................................"
customerOne.redeem_points_request(20)
hr
puts "PETUNIA MAKES A $30 PURCHASE................................"
customerOne.add_purchase(30)
puts customerOne.display_point_balance
hr
puts "PETUNIA ATTEMPTS TO REDEEM 80 pts................................"
customerOne.redeem_points_request(80)
puts "Success!"
puts customerOne.display_point_balance

hr
hr
# add new client2
clientTwo = Client.create("Awesome Apparel")
hr
puts "Welcome, #{clientTwo.name}. Your account number is #{clientTwo.account_id}"
puts "Your super secret key is, #{clientTwo.secret_key}. Don't forget and never reveal!"
hr
puts "SETTING POINTS PER DOLLAR................................"
clientTwo.points_per_dollar = 5
puts "You have set your points per dollar amount to #{clientTwo.points_per_dollar} point(s) per dollar"
hr
puts "SETTING REDEMPTION LIMIT................................"
clientTwo.customer_point_limit = 500
puts "You have set your customer redemption points limit to #{clientTwo.customer_point_limit}"
hr
# add new customer2
puts "ADDING NEW REWARDS CUSTOMER................................"
customerTwo = Customer.create("peter@email.com", clientTwo.account_id)
puts "New customer Email: #{customerTwo.email} | Account Id: #{customerTwo.account_id} | #{customerTwo.display_point_balance}"
hr
puts "PETER MAKES A $120 PURCHASE................................"
customerTwo.add_purchase(120)
puts customerTwo.display_point_balance
hr
puts "PETER ATTEMPTS TO REDEEM 1500 pts................................"
customerTwo.redeem_points_request(1500)
hr
puts "PETER MAKES A $30 PURCHASE................................"
customerTwo.add_purchase(30)
puts customerTwo.display_point_balance
hr
puts "PETER ATTEMPTS TO REDEEM 80 pts................................"
customerTwo.redeem_points_request(80)
puts "Success!"
puts customerTwo.display_point_balance
