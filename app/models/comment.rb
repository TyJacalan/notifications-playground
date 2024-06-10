class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :mentions, as: :record, dependent: :destroy, class_name: "Noticed::Event"

  validates :body, presence: :true

  after_create_commit { broadcast_notifications }

  private

  def broadcast_notifications
    message = "#{user.email} commented on your post: #{post.title}"
    
    CommentNotifier.with(record: self, message: ).deliver_later(post.user)
    
    broadcast_prepend_to "notifications_#{post.user.id}",
                          target: "notifications_#{post.user.id}",
                          partial: "notifications/notification",
                          locals: { user:, post:, message:}
  end
end