class Comment < ActiveRecord::Base

  validates :title, :body, :commentable_id, :commentable_type, presence: true

  belongs_to :commentable, polymorphic: true

end
