class ShortenedURL < ActiveRecord::Base
  include SecureRandom

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true

  ## Associations

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  def self.random_code
    random = SecureRandom.urlsafe_base64(nil, false)
    while ShortenedURL.exists?(short_url: random)
      random = SecureRandom.urlsafe_base64(nil, false)
    end

    random
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = ShortenedURL.random_code

    ShortenedURL.create!(long_url: long_url,
                         short_url: short_url,
                         user_id: user.id)
  end

  def num_clicks
    Visit.select(user_id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    Visit.select(:user_id).where('created_at < ?', 10.minutes.ago).distinct.count
  end

end
