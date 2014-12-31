class QuestionFollower

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM followers')
    results.map { |result| QuestionFollower.new(result) }
  end

  attr_reader :id, :question_id, :user_id

  def initialize(options = {})
    @id = nil
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      followers
    WHERE
      followers.id = ?
    SQL

    results.map { |result| Follower.new(result) }
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.fname, users.lname
    FROM
      followers
    JOIN
      users ON followers.question_id = users.id
    WHERE
      followers.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      questions
    JOIN
      followers ON questions.id = followers.question_id
    WHERE
      followers.user_id = ?
    SQL

    results.map { |result| Question.new(result)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL)
    SELECT
      questions.body, questions.title,  COUNT(*) AS num_followers
    FROM
      followers
    JOIN
      questions ON followers.question_id = questions.id
    GROUP BY
      followers.question_id
    ORDER BY
      num_followers DESC, questions.body, questions.title
    SQL

    results.map { |result| Question.new(result) }.take(n)
  end
end
