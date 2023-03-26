
require "faker"

srand(123)

length = 250
year = 2020

names = (1..length).to_a.map { [Faker::Name.first_name, Faker::Name.middle_name, Faker::Name.last_name].join(" ") }.uniq.shuffle
years = (1..length).to_a.shuffle


puts "It's currently the year of #{year}."
puts names.zip(years).map { "#{_1} was born in the year #{_2}." }.join(" ")
puts "How old would #{names[0]} be, if still alive? Answer only with the age, no text."
puts
puts "Answer: #{year - years[0]}"


puts "How old would #{names[length/2]} be, if still alive? Answer only with the age, no text."
puts
puts "Answer: #{year - years[length/2]}"
