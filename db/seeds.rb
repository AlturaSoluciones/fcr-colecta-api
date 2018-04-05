# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create name: 'Quito', latitude: -0.172600, longitude: -78.485000
City.create name: 'Ambato', latitude: -1.238700, longitude: -78.634100
City.create name: 'Cuenca', latitude: -2.899000, longitude: -79.010600
City.create name: 'Guayaquil', latitude: -2.170978, longitude: -79.921328
City.create name: 'Ibarra', latitude: 0.339200, longitude: -78.122200
City.create name: 'Portoviejo', latitude: -1.054700, longitude: -80.452500

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

cities = {}
CSV.foreach(Rails.root.join('db', 'support', 'new_lugares.csv')) do |row|
  (cities[row[0]] ||= City.find_by(name: row[0])).places << Place.create(name: row[1], latitude: row[2], longitude: row[3], address: row[4])
end
