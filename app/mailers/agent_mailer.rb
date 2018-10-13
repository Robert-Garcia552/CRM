class AgentMailer < ApplicationMailer
    def password_reset(user)
        @agent = user
        mail to: @agent.email, subject: "Password reset"
    end
end
