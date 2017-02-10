# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  # def completed_polls
  #
  #
  #   all_polls_min_one_response = responses.question.poll
  #   query_result = all_polls_min_one_response.joins(:questions).group(:polls.id).select("polls.id, COUNT(*) AS total_poll_questions")
  #
  #   t = {}
  #   query_result.each { |r| t[r.id] = r.total_poll_questions }
  #   t
  # end

  def polls_responded_to
    q = responses
      .joins("JOIN answer_choices ON answer_choices.id = responses.answer_choice_id")
      .joins("LEFT OUTER JOIN questions ON questions.id = answer_choices.question_id")
      .joins("JOIN polls ON polls.id = questions.poll_id")
      .group("polls.id")
      .select("polls.title AS poll_title, COUNT(questions.id) AS num_questions, COUNT(answer_choices.id) AS num_answered_questions")

    q.map { |r| "title: #{r.poll_title}, number of poll questions: #{r.num_questions}, number of answered questions for this poll: #{r.num_answered_questions}" }






      # .select("polls.id, COUNT(*) AS num_total_questions, COUNT(answer_choices.id) AS num_responses")
  end

end
