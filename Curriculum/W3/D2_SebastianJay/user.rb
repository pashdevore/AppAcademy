class User
  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM users')
    results.map { |result| User.new(result) }
  end

  attr_accessor :fname, :lname, :id

  def initialize(options = {})
    @id = options['id']
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

  def self.find_by_id(id)
    results= QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      users
    WHERE
      users.id = ?
    SQL

    results.map { |result| User.new(result) }
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
