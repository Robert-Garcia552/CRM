class ClientsController < ApplicationController
	before_action :validate_access

	def new
		@client = Client.new
  end

  def create
    @client = current_user.clients.new(client_params)
    if @client.save
      redirect_to agent_path(current_user), success: "Client successfully created."
    else
      redirect_to new_client_path, danger: "Failed to create client due to: #{@client.errors.full_messages.join(', ').downcase}."
    end
	end

	def show
		@client = Client.find(params[:id])
		@case = @client.cases.all
		@case_comments = Comment.all
  end

  private
  
  def validate_access
    redirect_to root_path unless current_user != nil
  end

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
