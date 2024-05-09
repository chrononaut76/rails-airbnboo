# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "faker"
require "geocoder"

Faker::Config.locale = "en"

new_user = User.create(
  email: Faker::Internet.email,
  password: '123456',
  first_name: 'First',
  last_name: 'Last',
  is_host: true
)

image_filenames = Dir.glob("app/assets/images/house_images/*").map { |file| File.basename(file) }

canadian_provinces = ['Alberta', 'British Columbia', 'Manitoba', 'New Brunswick', 'Newfoundland and Labrador', 'Nova Scotia', 'Ontario', 'Prince Edward Island', 'Quebec', 'Saskatchewan']
# The reason I put 100 is that it filters out teh locations that are not in Canada
100.times do
  latitude = rand(41.676555..83.116667)
  longitude = rand(-140.99778..-52.648098)

  result = Geocoder.search([latitude, longitude], country: 'Canada')

  canadian_result = result.find { |r| canadian_provinces.include?(r.state) }

  next unless canadian_result

  city = canadian_result.city

  new_location = Location.create!(
    name: Faker::Address.unique.community,
    address: "#{city}, #{canadian_result.state}, Canada",
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price(range: 50..200.0),
    image_url: "house_images/#{image_filenames.sample}",
    user_id: new_user.id
  )
  puts new_location.save ? "Successfully created location" : "Error while creating location"
end
