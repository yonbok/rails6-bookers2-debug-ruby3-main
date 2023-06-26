class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_many :followers, through: :reverse_of_relationships, source: :folllower
  has_many :followings, through: :relationships, source: :followed
end
