class QuestionLike
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    results.map { |result| self.class.new(result) }
  end

  attr_reader :id, :user_id, :question_id

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
      users
    WHERE
      users.id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users
    JOIN
      questions_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      COUNT(*)
    FROM
      users
    JOIN
      questions_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.question_id = ?
    SQL
    num_likes
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      COUNT(*)
    FROM
      users
    JOIN
      question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.user_id = ?
    SQL
    results.map { |result| QuestionLike.new(result)}
  end
end
