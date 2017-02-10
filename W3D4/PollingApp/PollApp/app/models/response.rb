# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response, :author_cannot_respond

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def author_cannot_respond
    if answer_choice.question.poll.author_id = user_id
      errors[:author] << "you can't respond to your own question!"
    end
  end

  def not_duplicate_response
    if respondent_already_answered?
      errors[:duplicate] << "you can't respond twice to the same question"
    end
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end

  def sibling_responses
    question.responses.where.not(id: self.id)
  end

end
