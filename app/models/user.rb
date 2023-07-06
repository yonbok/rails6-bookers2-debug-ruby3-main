class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :favorited_books, through: :favorites, source: :book

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_one_attached :profile_image


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,  length: { maximum: 50 }


  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end


  def self.looks(search,word)
    if search == "forward_match"
                 @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
                 @user = User.where("name LIKE?","%#{word}")
    elsif search == "perfect_match"
                 @user = User.where("name LIKE?", "#{word}")
    elsif search == "partial_match"
                 @user = User.where("name LIKE?","%#{word}%")
    else
                 @user = User.all
    end
  end

end
