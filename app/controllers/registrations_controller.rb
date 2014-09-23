class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.create(params["user"])
    @user.roles << Role.find_by_name("JobSeeker")
    sign_in @user
    redirect_to root_path
  end
end