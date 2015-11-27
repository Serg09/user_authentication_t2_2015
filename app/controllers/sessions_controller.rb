class SessionsController < ApplicationController
  def login
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      # User provided valid password
      session[:id] = user.id
      redirect_to root_path,
        notice: "Welcome back #{user.first_name.titleize}"
    else
      flash[:danger] = ["Invalid email or password", "Did you try 5 stars?", "You has a dumb", "You’re an idiot", "Ah ah ah!"].sample
      render :login
    end
  end

  def destroy
    if user = current_user
      session.delete(:id)
      redirect_to root_path,
        notice: "#{user.email} has been logged out."
    end
  end
end


