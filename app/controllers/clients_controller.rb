class ClientsController < ApplicationController
    def new
    end

    def create
		@client = Client.new(client_params)
			if @client.save
				redirect_to agent_path, success: "Agent successfully created", method: :show
			else
				redirect_to new_client_path, danger: "Failed to create client due to: #{@client.errors.full_messages.join(', ').downcase}."
			end
	end

    def show
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
								:image
							)
	end
end
