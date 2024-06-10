class CommentNotifier < ApplicationNotifier
  deliver_by :database

  notification_methods do 
    def message
      params[:message]
    end
  end
end