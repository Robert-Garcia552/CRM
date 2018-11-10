class ClientsController < ApplicationController
	def new
		@client = Client.new
    end

    def create
		@client = current_user.clients.new(client_params)
			if @client.save
				redirect_to agent_path(current_user), success: "Client successfully created."
			else
				redirect_to clients_path, danger: "Failed to create client due to: #{@client.errors.full_messages.join(', ').downcase}."
			end
	end

	def show
			@client = Client.find(params[:id])
			@case = @client.cases.all
  end

    private

    def client_params
		params.
			require(:client).
				permit(
								:email,
								:first_name,								
								:last_name,
								:phone_number,
								:agent_id,
								:image
							)
	end
end
