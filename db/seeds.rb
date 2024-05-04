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
new_user = User.create(
  email: Faker::Internet.email,
  password: '123456',
  first_name: 'First',
  last_name: 'Last',
  is_host: true
)

image_filenames = Dir.glob("app/assets/images/house_images/*").map { |file| File.basename(file) }

10.times do
  new_location = Location.create!(
    name: Faker::Address.unique.community,
    address: Faker::Address.street_address,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price(range: 50..200.0),
    image_url: "house_images/#{image_filenames.sample}",
    user_id: new_user.id
  )
  puts new_location.save ? "Successfully created location" : "Error while creating location"
end
