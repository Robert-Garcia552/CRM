class ApplicationController < ActionController::Base
    helper_method :current_user

    add_flash_types :danger, :info, :warning, :success
  
    def current_user
      if (agent_id = session[:agent_id])
        @current_user ||= Agent.find_by(id: agent_id)
      elsif (agent_id = cookies.signed[:agent_id])
        agent = Agent.find_by(id: agent_id)
        if agent && agent.authenticated?(cookies[:remember_token])
          login agent
          @current_user = agent
        end
      end
    end
  
    def require_logged_in
      return true if current_user
  
      return redirect_to root_path
    end
  
    def remember(agent)
      agent.remember
      cookies.permanent.signed[:agent_id] = agent.id
      cookies.permanent[:remember_token] = agent.remember_token
    end
  
     private
  
      def login(agent)
         session[:agent_id] = agent.id
      end
  
end
