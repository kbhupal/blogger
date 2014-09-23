class HomeController < ApplicationController
  def index
    if current_user.is_employer
      redirect_to employer_home_path
    end
  end
end