class Post < ActiveRecord::Base
  acts_as_votable

  validates :user_id, presence: true
  validates :image, presence: true
  validates :caption, length: { minimum: 3, maximum: 300 }

  has_attached_file :image, styles: { :medium => "640px"}

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  belongs_to :user

  has_many :comments, dependent: :destroy

end
