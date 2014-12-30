class Tagging < ActiveRecord::Base

  ## Associations
  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :visited_url,
    class_name: "ShortenedURL",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )
  

end
