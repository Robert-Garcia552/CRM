class CasesController < ApplicationController
	before_action :validate_access

	def new
		@case = Case.new
	end

	def index
	end

	def create
    client = Client.find(params[:client_id])
    @case = client.cases.new(case_params)
		if @case.save
			redirect_to client_path(@case.client_id), success: "Case successfully created."
		else
			redirect_to new_case_path(id: params[:client_id]), danger: "Failed to create case due to: #{@case.errors.full_messages.join(', ').downcase}."
		end
	end

	def show
		current_user.clients.map do |client|
			client = Client.find_by(email: "#{client.email}")
			@case = client.cases.find(params[:id])
		end	
  end

	private
	
	def validate_access
		redirect_to root_path unless current_user != nil
	end

  def case_params
		params.
			require(:case).
				permit(
								:category,
								:description,
                :comments,
                :status,
                :estimated_completion_date,
								:client_id,
								:images
							)
	end
end
