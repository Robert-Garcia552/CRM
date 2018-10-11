class AgentsController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]
	before_action :validate_access, only: [:edit, :update]

	def new
		@agent = Agent.new
	end

	def create
		@agent = agent.new(agent_params)
			if @user.save
				login(@agent)
				redirect_to @agent, success: "Agent successfully created"
			else
				redirect_to new_agent_path, danger: "Invalid login due to: #{@agent.errors.full_messages.join(', ').downcase}."
			end
	end

	def edit
	end

	def update
		@agent.update(agent_params)
		redirect_to @agent, success: "Agent successfully updated"
	end

	private

	def set_agent
		@agent = agent.find(params[:id])
	end

	def validate_access
		redirect_to root_path unless current_agent.id == @agent.id
	end

	def agent_params
		params.
			require(:agent).
				permit(
								:email,
								:first_name,
								:middle_name,
								:last_name,
								:birthdate,
								:phone_number,
								:password,
								:password_confirmation,
								:image
							)
	end

end
