class SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    puts "#################\n\n"
    puts resource
    if resource.is_a?(User)
      puts "#################"
      puts "this should be called"
      resource.is_admin? ? admin_home_index_path : root_path
    else
      super
    end
  end
end