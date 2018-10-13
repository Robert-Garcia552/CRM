class SessionsController < ApplicationController
    def new
    end
  
    def create
      @agent = Agent.find_by(email: params[:email])
                .try(:authenticate, params[:password])
      @permission = params[:permission]
  
      if @agent
        login(@agent) #comes from ApplicationController
        redirect_to agent_path(@agent[:id]), success: "Logged in as #{@agent[:first_name]}."
          if @permission == "1"
            remember(@agent)
          end #comes from ApplicationController
      else
        redirect_to new_sessions_path, danger: "Email / Password combination does not exist."
      end  
    end
  
    def destroy
      current_user.forget
      session[:agent_id] = nil
      cookies.delete :remember_token
      cookies.delete :agent_id
      redirect_to root_path, success: "You have successfully logged out."
    end
end
