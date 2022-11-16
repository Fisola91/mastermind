# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Game.destroy_all
ValidColor.destroy_all
Player.destroy_all

color = ValidColor.create!(colors: %w(
                              RED
                              ORANGE
                              YELLOW
                              GREEN
                              BLUE
                              PURPLE
  )
)


# Game.create!(passcode: )

Player.create!(name: "Scoal")
