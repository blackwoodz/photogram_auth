class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :liked_photos, :through => :likes, :source => :photo

  has_many :photos
  has_many :likes
  has_many :comments

  validates :username, presence: true, uniqueness: true

  mount_uploader :avatar, AvatarUploader
end
