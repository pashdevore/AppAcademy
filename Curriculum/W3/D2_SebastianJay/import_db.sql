CREATE TABLE users
(
    id INTEGER PRIMARY KEY,
    fname VARCHAR(255) NOT NULL,
    lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions
(
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE followers
(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies
(
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  parent_reply INTEGER,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (parent_reply) REFERENCES replies(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE question_likes
(
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Albert', 'Einstein'),
  ('Captain', 'Kirk'),
  ('Pash', 'DeVore'),
  ('Sebastian', 'Jay'),
  ('Lebron', 'James');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('What does E=mc2 equal?', 'Ive been wondering about science and stuff...',
    (SELECT id FROM users WHERE fname = 'Albert')),
  ('Tootsie Pop', 'How many licks does it take to get to the center?',
    (SELECT id FROM users WHERE fname = 'Captain'));

INSERT INTO
  followers (user_id, question_id)
VALUES
  ((SELECT id FROM users WHERE fname = 'Sebastian'),
    (SELECT id FROM questions WHERE title = 'Tootsie Pop')),
  ((SELECT id FROM users WHERE fname = 'Pash'),
    (SELECT id FROM questions WHERE title = 'Tootsie Pop'));

INSERT INTO replies (body, parent_reply, user_id, question_id)
VALUES
(
  'The answer is 454.',
  NULL,
  (SELECT id FROM users WHERE fname = 'Pash'),
  (SELECT id FROM questions WHERE title = 'Tootsie Pop')
);

INSERT INTO
  question_likes (user_id, question_id)
VALUES
(
  (SELECT id FROM users WHERE fname = 'Sebastian'),
  (SELECT id FROM questions WHERE title = 'Tootsie Pop')
);
