# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tags = [
    "breakfast", 
    "lunch", 
    "dinner", 
    "dessert", 
    "appetizer", 
    "entree", 
    "side", 
    "vegetarian", 
    "vegan", 
    "glutenfree", 
    "lowcarb",
    "keto"
]

tags.map do |tag|
    Tag.create(name: tag)
end