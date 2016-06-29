# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Roadshow.destroy_all
User.destroy_all

boris = User.create!(email: 'boris@brexit.org', password: 'testtest')
Roadshow.create!(company: "AXA", url: "http://axa.com", message: "AXA has mandated BNP Paribas")
Roadshow.create!(company: "Scor", url: "http://scor.com", message: "Scor has mandated JP Morgan")
Roadshow.create!(company: "Humanis", url: "http://humanis.com", message: "Humanis has mandated Natixis")

