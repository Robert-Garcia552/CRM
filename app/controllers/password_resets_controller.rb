class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @agent = Agent.find_by(email: params[:password_reset][:email].downcase)
    if @agent
      @agent.create_reset_digest
      @agent.send_password_reset_email 
      redirect_to root_path, success: "Email sent with password reset instructions."
    else
      redirect_to password_resets_new_path, danger: "Email not found."
    end
  end

  def edit
  end

  def update
    if params[:agent][:password].empty?                  # Case (3)
      @agent.errors.add(:password, "can't be empty")
      render 'edit'
    elsif @agent.update_attributes(user_params)          # Case (4)
      login(@agent)
      redirect_to @agent, success: "Password has been reset."
    else
      render 'edit'                                     # Case (2)
    end
  end
  
  private

  def user_params
    params.require(:agent).permit(:password, :password_confirmation)
  end

  def get_user
    @agent = Agent.find_by(email: params[:email])
  end

  def valid_user
    unless (@agent && @agent.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end

  # Checks expiration of reset token.
  def check_expiration
    if @agent.password_reset_expired?
      redirect_to new_password_reset_path, danger: "Password reset has expired."
    end
  end
end