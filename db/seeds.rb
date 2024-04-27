# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts 'Clearing db'
rails db:reset

8.times do
  new_location = Location.new(
    name: 'Gingerbread House',
    address: 'Deep in the woods',
    description: 'An edible lodging made of your favorite sweets from childhood!',
    price: 100.0,
    image_url: 'gingerbread_house.jpg',
    user_id: 1
    )
    puts "Seeding new location: #{new_location.name}"
end
