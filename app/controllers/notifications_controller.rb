class NotificationsController < ApplicationController
    def index
        @notifications = current_user.notifications.includes(:event).reverse
    end
end