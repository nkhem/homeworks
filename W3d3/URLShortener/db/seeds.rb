# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
nicole = User.create!(name: 'Nicole', email: 'nkhemenway@gmail.com')
sweta = User.create!(name: 'Sweta', email: 'swetagsanghavi@gmail.com')

ShortenedUrl.destroy_all
short_url_one = ShortenedUrl.create!(short_url: 'nicole.com', long_url: 'nicolehemenway.com', user_id: User.find_by_name('Nicole').id)
short_url_two = ShortenedUrl.create!(short_url: 'sweta.com', long_url: 'swetasanghavi.com', user_id: User.find_by_name('Sweta').id)
short_url_three = ShortenedUrl.create!(short_url: ShortenedUrl.random_code, long_url: 'swetasanghaviswetasanghavi.com', user_id: User.find_by_name('Sweta').id)

Visit.destroy_all
visit_1 = Visit.record_visit!(User.find_by_name('Nicole'), ShortenedUrl.find_by_short_url('sweta.com'))
