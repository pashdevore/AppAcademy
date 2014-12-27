require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database

  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end
end

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

  def self.find_by_id(num)
    results = QuestionsDatabase.instance.execute(<<-SQL, num)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL

    results.map { |result| Question.new(result) }
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

class User
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(options = {})
    @id = nil
    @fname = options['fname']
    @lname = options['lname']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    params = [self.fname, self.lname]
    QuestionsDatabase.instance.execute(<<-SQL, *params)
    INSERT INTO
    users (fname, lname)
    VALUES
    (?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end


  def self.find_by_name(first, last)
    results = QuestionsDatabase.instance.execute(<<-SQL, first, last)
    SELECT
      *
    FROM
      users
    WHERE
      users.fname = ?
    AND
      users.lname = ?
    SQL

    results.map { |result| User.new(result) }
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      ? = replies.user_id
    SQL

    results.map { |result| Reply.new(result) }
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(self.id)
  end

  def liked_questions
    QuestionFollower.liked_questions_for_user_id(self.id)
  end

  def average_karma

  end
end

class Reply
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies')
    results.map { |result| Reply.new(result) }
  end

  attr_accessor :body
  attr_reader :id, :user_id, :question_id, :parent_reply

  def initialize(options = {})
    @id = nil
    @body = options['body']
    @user_id = options['user_id']
    @question_id = options['question_id']
    @parent_reply = options['parent_reply']
  end

  def create
    raise 'already saved!' unless self.id.nil?

    params = [self.body, self.user_id, self.question_id, self.parent_reply]
    QuestionsDatabase.instance.execute(<<-SQL, *params)
    INSERT INTO
    replies (body, user_id, question_id, parent_reply)
    VALUES
    (?, ?, ?, ?)
    SQL

    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def self.find_by_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
    *
    FROM
      replies
    WHERE
      replies.question_id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.user_id = ?
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

  def question
    results = QuestionsDatabase.instance.execute(<<-SQL, self.question_id)
    SELECT
      *
    FROM
      questions
    WHERE
      questions.id = ?
    SQL

    results.map { |result| Question.new(result) }
  end

  def parent_reply
    results = QuestionsDatabase.instance.execute(<<-SQL, self.parent_reply)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = ?
    SQL

    results.map { |result| Reply.new(result) }
  end

  def child_replies
    results = QuestionsDatabase.instance.execute(<<-SQL, self.id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.parent_reply = ?
    SQL

    results.map { |result| Reply.new(result) }
  end
end

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

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      users.fname, users.lname
    FROM
      followers JOIN users ON followers.question_id = users.id
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
        questions JOIN followers ON questions.id = followers.question_id
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
      followers JOIN questions ON followers.question_id = questions.id
    GROUP BY
      followers.question_id
    ORDER BY
      num_followers DESC, questions.body, questions.title
    SQL

    results.map { |result| Question.new(result) }.take(n)
  end
end

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

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
    SELECT
      *
    FROM
      users JOIN questions_likes ON users.id = question_likes.user_id
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
      users JOIN questions_likes ON users.id = question_likes.user_id
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
      users JOIN question_likes ON users.id = question_likes.user_id
    WHERE
      question_likes.user_id = ?
    SQL
    results.map { |result| QuestionLike.new(result)}
  end
end
