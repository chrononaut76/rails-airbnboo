# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

8.times do
  new_location = Location.new(
    name: 'Gingerbread House',
    address: 'Deep in the woods',
    description: 'An edible lodging made of your favorite sweets from childhod!',
    price: 100.0,
    image_url: 'images/gingerbread_house.jpg',
    user_id: 1
  )
  puts "Created new location #{new_location.name}"
end
