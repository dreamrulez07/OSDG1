class Post < ActiveRecord::Base
  attr_accessible :content, :tag_list
  acts_as_taggable
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

#  default_scope order: 'posts.created_at DESC'

  has_many :comments, dependent: :destroy
end
