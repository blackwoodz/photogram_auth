class Photo < ActiveRecord::Base
  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :fans, :through => :likes, :source => :user
  has_many :likes
  has_many :comments

  validates :user_id, presence: true

  def fan_sentence
    return fan_list.to_sentence(words_connector: ', ', last_word_connector: ' and ')
  end

  def fan_list
    return fans.pluck(:username)
  end

end
