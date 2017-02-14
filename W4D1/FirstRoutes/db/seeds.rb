# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create!(username: "jawn_smith")
User.create!(username: "jack")
User.create!(username: "puffy")
User.create!(username: "jacqueline")
User.create!(username: "velmadoo")

Contact.destroy_all
Contact.create!(name: "Jack", email: "jack@jmail.com", user_id: User.find_by(username: "puffy").id)
Contact.create!(name: "Puffin", email: "puffy@puffmail.com", user_id: User.find_by(username: "jawn_smith").id)
Contact.create!(name: "Jon Smith", email: "jon@jon.com", user_id: User.find_by(username: "velmadoo").id)
Contact.create!(name: "Jon Smith", email: "jon@jon.com", user_id: User.find_by(username: "puffy").id)
Contact.create!(name: "Velma", email: "velmaaaaa@gmail.com", user_id: User.find_by(username: "puffy").id)
Contact.create!(name: "Velma", email: "voodooo@gmail.com", user_id: User.find_by(username: "jacqueline").id)
Contact.create!(name: "Jacqueline", email: "jacqueline@gmail.com", user_id: User.find_by(username: "jawn_smith").id)

ContactShare.destroy_all
ContactShare.create!(contact_id: Contact.find_by(name: "Puffin").id, user_id: User.find_by(username: "jawn_smith").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Jacqueline").id, user_id: User.find_by(username: "jawn_smith").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Jack").id, user_id: User.find_by(username: "puffy").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Jon Smith").id, user_id: User.find_by(username: "velmadoo").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Jon Smith").id, user_id: User.find_by(username: "puffy").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Velma").id, user_id: User.find_by(username: "puffy").id)
ContactShare.create!(contact_id: Contact.find_by(name: "Velma").id, user_id: User.find_by(username: "jacqueline").id)
