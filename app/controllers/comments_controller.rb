class CommentsController < ApplicationController
	before_action :validate_access

  def new
    @comment = Comment.new
  end

	def create
		@case = Case.find(params[:case_id])
		@comment = @case.comments.new(comments_params)
		if @comment.save
			redirect_to client_path(@case.client_id), success: "Comment successfully created."
		else
			redirect_to new_comment_path, danger: "Failed to create comment due to: #{@comment.errors.full_messages.join(', ').downcase}."
		end	
	end
	 
	private

	def validate_access
		redirect_to root_path unless current_user != nil
	end

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