class CommentsController < ApplicationController

	def new
        @comment = Comment.new
    end

	def create
		@case = Case.find(params[:case_id])
		@comment = @case.comments.new(comments_params)
		if @comment.save
			redirect_to agent_path(current_user), success: "Comment successfully created."
		else
			redirect_to new_comment_path, danger: "Failed to create comment due to: #{@comment.errors.full_messages.join(', ').downcase}."
		end	
	end
	
	private

	def comments_params
		params.
			require(:comment).
				permit(
						:author,
						:comment,								
						:case_id
						)
	end


end
