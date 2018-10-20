class CasesController < ApplicationController

	def new
		@case = Case.new
	end

	def index
	end

	def create
		current_user.clients.map do |client|
			client = Client.find_by(email: "#{client.email}")
			@case = client.cases.new(case_params)
				if @case.save
					redirect_to agent_path(current_user), success: "Case successfully created.", action: :show
				else
					redirect_to new_case_path, danger: "Failed to create case due to: #{@case.errors.full_messages.join(', ').downcase}."
				end
		end	
	end

    def show
    end

    private

    def case_params
		params.
			require(:case).
				permit(
								:category,
								:description,
								:comments,
								:client_id,
								:agent_id
							)
	end
end
