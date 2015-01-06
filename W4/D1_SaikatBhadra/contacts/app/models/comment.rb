class Comment < ActiveRecord::Base
  validates :user_id, :text, :commentable_id, :commentable_type, :presence => true
  belongs_to :commentable, :polymorphic => true
end
