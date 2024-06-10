class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)

        respond_to do |format|
            if @comment.save
                flash[:notice] = "New Comment created"
                format.turbo_stream
            else
                flash[:alert] = @comment.errors.full_messages.first.to_s
                format.turbo_stream
            end
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body, :user_id, :post_id)
    end
end