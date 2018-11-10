class CommentsController < ApplicationController

    def new
        @comment = Comment.new
    end

    def create
		current_user.clients.map do |client|
			client = Client.find_by(email: "#{client.email}")
			@case = client.cases.map do |cases|
				cases = Case.find(params[:id])
				@comment = cases.comments.new(comments_params)
				if @comment.save
					redirect_to agent_path(current_user), success: "Comment successfully created."
				else
					redirect_to new_comment_path, danger: "Failed to create comment due to: #{@comment.errors.full_messages.join(', ').downcase}."
				end
			end
		end	
	end
	
	private

	def comments_params
		params.
			require(:comments).
				permit(
						:author,
						:comment,								
						:case_id
						)
	end


end
