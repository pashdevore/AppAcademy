# == Schema Information
#
# Table name: actor
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movie
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director    :integer
#
# Table name: casting
#
#  movieid     :integer      not null, primary key
#  actorid     :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      title
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      title
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Harrison Ford'
    AND
      casting.ord != 1
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      m.title, (
        SELECT
          actor.name
        FROM
          actor
        INNER JOIN
          casting
        ON
          actor.id = casting.actorid
        INNER JOIN
          movie
        ON
          movie.id = casting.movieid
        WHERE
          casting.ord = 1
        AND
          movie.id = m.id
      )
    FROM
      movie m
    WHERE
      yr = 1962
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      m.yr, COUNT(m.id)
    FROM
      movie m
    INNER JOIN
      casting c
    ON
      m.id = c.movieid
    INNER JOIN
      actor a
    ON
      c.actorid = a.id
    WHERE
      a.name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
      COUNT(m.id) > 1
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    -- SELECT
    --   m.title, ( SELECT
    --     a.name
    --       FROM
    --         actor a
    --       INNER JOIN
    --         casting c
    --       ON
    --         a.id = c.actorid
    --       WHERE
    --         c.ord = 1 )
    -- FROM
    --   movie m
    -- WHERE
    --   m.id
    --   IN
    --   ( SELECT
    --       c.movieid
    --     FROM
    --       c
    --     WHERE
    --       a.name = 'Julie Andrews' )
    -- SELECT DISTINCT
    --   m_subset.title, m_subset.actorid
    -- FROM
    --   ( SELECT
    --     m.title, casting.actorid, m.id
    --   FROM
    --     movie m
    --   INNER JOIN
    --     casting
    --   ON
    --     casting.movieid = m.id
    --   WHERE
    --     casting.ord = 1) m_subset
    --   INNER JOIN
    --     actor a
    --   ON
    --     m_subset.actorid = a.id
    -- WHERE
    --   a.name = 'Julie Andrews'
    SELECT
      sq.title, sq.name
    FROM
      (
        SELECT
          m.title, a.name, c.ord
        FROM
          casting c
        INNER JOIN
          actor a
        ON
          a.id = c.actorid
        INNER JOIN
          movie m
        ON
          m.id = c.movieid
        WHERE
          m.id
        IN
          ( SELECT
              movie.id
            FROM
              movie
            INNER JOIN
              casting
            ON
              movie.id = casting.movieid
            INNER JOIN
              actor
            ON
              actor.id = casting.actorid
            WHERE
              actor.name = 'Julie Andrews' )
      ) sq
    WHERE
      sq.ord = 1
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT DISTINCT
      a.name
    FROM
      actor a
    INNER JOIN
      casting c
    ON
      c.actorid = a.id
    INNER JOIN
      movie m
    ON
      c.movieid = m.id
    WHERE
      c.ord = 1
    GROUP BY
      a.name
    HAVING
      COUNT(m.id) >= 15
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      m.title, COUNT(c.actorid)
    FROM
      movie m
    INNER JOIN
      casting c
    ON
      c.movieid = m.id
    GROUP BY
      m.id
    HAVING
      m.yr = 1978
    ORDER BY
      COUNT(c.actorid) DESC, m.title
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      a.name
    FROM
      actor a
    INNER JOIN
      casting c
    ON
      a.id = c.actorid
    WHERE
      c.movieid
    IN
      (
        SELECT
          g.movieid
        FROM
          casting g
        WHERE
          g.actorid =
            (
              SELECT
                z.id
              FROM
                actor z
              WHERE
                z.name = 'Art Garfunkel'
            )
      )
    AND
      a.name != 'Art Garfunkel'
  SQL
end
