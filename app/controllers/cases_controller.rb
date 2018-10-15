class CasesController < ApplicationController

	def new
		@case = Case.new
    end

	def create
		current_user.clients.map do |client|
		@case = current_user.clients.find_by(email: "#{client.email}").cases.new(case_params)
		end
			if @case.save
				redirect_to agent_path(current_user), success: "Case successfully created."
			else
				redirect_to cases_path, danger: "Failed to create case due to: #{@case.errors.full_messages.join(', ').downcase}."
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
								:comments
							)
	end
end
