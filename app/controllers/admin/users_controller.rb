class Admin::UsersController < Admin::ApplicationController

  def index
  end

  def new
    @user = User.new
  end

  def create
    user = User.new
    @errors = []
    ActiveRecord::Base.transaction do
      update_new_user user, params["user"]
    end
    redirect_to admin_home_index_path if @errors.blank?
  end

  private

  def update_new_user user, new_user_hash
    user.update_attributes(new_user_hash)
    if user.errors.blank?
      user.save!
      user.roles << Role.find_by_name("Editor")
    else
      @errors = user.errors.full_messages
      @errors.each do |e|
        flash[:error] = e
      end
      redirect_to new_admin_user_path
    end
  end
end