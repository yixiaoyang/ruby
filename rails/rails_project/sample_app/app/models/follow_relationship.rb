class FollowRelationship < ActiveRecord::Base
  # :followe和:follower模型使不存在的，实际上就是一个user，因此需要指定模型类User
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  
  # 关注者和被关注者都必须存在
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
