class Question
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions')
    results.map { |result| Question.new(result) }
  end

  attr_accessor :title, :body, :user_id
  attr_reader :id

  def initialize(options = {})
    @id = nil
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    params = [self.title, self.body, self.user_id]
    QuestionsDatabase.instance.execute(<<-SQL, *params)
    INSERT INTO
      questions (title, body, user_id)
    VALUES
      (?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL

    results.map { |result| Questions.new(result) }
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.user_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def author
    results = QuestionsDatabase.instance.execute(<<-SQL, self.user_id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.question_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def followers
    QuestionFollower.followers_for_question_id(self.id)
  end

  def self.most_followed
    QuestionFollower.most_followed_questions(1)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.likers_for_question_id(self.id).count
  end
end
