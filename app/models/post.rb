class Post < ActiveRecord::Base
  has_reputation :votes, source: :user, aggregated_by: :sum
  attr_accessible :content, :tag_list
  acts_as_taggable
  belongs_to :user

  validates :content, presence: true
  validates :user_id, presence: true

#  default_scope order: 'posts.created_at DESC'

  has_many :comments, dependent: :destroy

end
