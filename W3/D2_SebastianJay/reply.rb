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

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id)
    SELECT
      *
    FROM
      replies
    WHERE
      replies.id = ?
    end
    SQL

    results.map { |result| Reply.new(result) }
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
