# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.destroy_all
User.create!(user_name: "Terry")
User.create!(user_name: "Nicole")
User.create!(user_name: "Arturo")
User.create!(user_name: "Sebastian")
User.create!(user_name: "Polly")
User.create!(user_name: "Jessica")

Poll.destroy_all
Poll.create!(title: "Drinks", author_id: User.find_by(user_name: "Polly").id)
Poll.create!(title: "Weather", author_id: User.find_by(user_name: "Polly").id)
Poll.create!(title: "Feelings", author_id: User.find_by(user_name: "Arturo").id)
Poll.create!(title: "Favorites", author_id: User.find_by(user_name: "Sebastian").id)

Question.destroy_all
Question.create!(text: "How do you take your coffee?", poll_id: Poll.find_by(title: "Drinks").id )
Question.create!(text: "Did you bring an umbrella today?", poll_id: Poll.find_by(title: "Weather").id)
Question.create!(text: "What's your most dominant feeling right now?", poll_id: Poll.find_by(title: "Feelings").id)
Question.create!(text: "What's your favorite SF neighborhood?", poll_id: Poll.find_by(title: "Favorites").id)
Question.create!(text: "What's your least favorite day of the week?", poll_id: Poll.find_by(title: "Favorites").id)

AnswerChoice.destroy_all
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%coffee%'").id, text: "Black")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%coffee%'").id, text: "One scoop sugar with almond milk")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%coffee%'").id, text: "Super creamy!")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%umbrella%'").id, text: "Yes")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%umbrella%'").id, text: "No :(")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%feeling%'").id, text: ":)")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%feeling%'").id, text: ":(")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%feeling%'").id, text: ":|")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%feeling%'").id, text: ">:[")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%feeling%'").id, text: "8-)")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Inner Richmond")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Financial District")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Chinatown")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Haight-Ashbury")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Castro")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%neighborhood%'").id, text: "Mission")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Monday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Tuesday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Wednesday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Thursday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Friday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Saturday")
AnswerChoice.create!(question_id: Question.find_by("questions.text LIKE '%day%'").id, text: "Sunday")

Response.destroy_all
Response.create!(user_id: User.find_by(user_name: "Nicole").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%creamy%'").id)
Response.create!(user_id: User.find_by(user_name: "Nicole").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%No%'").id)
Response.create!(user_id: User.find_by(user_name: "Nicole").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%:)%'").id)
Response.create!(user_id: User.find_by(user_name: "Nicole").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%China%'").id)
Response.create!(user_id: User.find_by(user_name: "Terry").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%creamy%'").id)
Response.create!(user_id: User.find_by(user_name: "Terry").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%No%'").id)
Response.create!(user_id: User.find_by(user_name: "Terry").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%8%'").id)
Response.create!(user_id: User.find_by(user_name: "Terry").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%Rich%'").id)

Response.create!(user_id: User.find_by(user_name: "Arturo").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%Inner%'").id)
Response.create!(user_id: User.find_by(user_name: "Arturo").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%Sun%'").id)
Response.create!(user_id: User.find_by(user_name: "Jessica").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%Blac%'").id)
Response.create!(user_id: User.find_by(user_name: "Polly").id, answer_choice_id: AnswerChoice.find_by("answer_choices.text LIKE '%Mission%'").id)
