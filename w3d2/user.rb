require_relative 'questions_database'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'

class User

  def self.find_by_id(id)
    user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        id = ?
    SQL

    return nil if user.empty?
    User.new(user.first)
  end

  def self.find_by_name(fname, lname)
    user = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = ? AND lname = ?
    SQL

    raise "#{fname} #{lname} is not a user" if user.empty?
    User.new(user.first)
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def average_karma
    my_questions_posted = self.authored_questions
    total_likes = my_questions_posted.map { |question| question.num_likes }
    total_likes.inject(:+) / my_questions_posted.size
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(id)
  end

  def authored_questions
    Question.find_by_author_id(id)
  end

  def authored_replies
    Reply.find_by_user_id(id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(id)
  end
end
