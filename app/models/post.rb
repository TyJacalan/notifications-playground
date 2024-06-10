class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  validates :title, :body, presence: true
end
