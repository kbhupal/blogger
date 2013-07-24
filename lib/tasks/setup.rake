desc "setup the application for use"
task :setup_sample_application => [:environment] do
  puts "Application is being prepared. Please wait."
  perm_list = ['application_admin', 'can_publish']
  perm_list.each do |p|
    Permission.find_or_create_by_name(p)
  end
  role_list = ["Admin", "Editor", "Reporter"]
  role_list.each do |r|
    Role.find_or_create_by_name(r)
  end

  Role.find_by_name("Admin").permissions << Permission.all
  Role.find_by_name("Editor").permissions << Permission.find_by_name("can_publish")

  # Create Dummy Admin User
  user = User.create(:name => "Puneet Goyal", :email => "puneet.goyal@studypadinc.com", :password => "1234567x", :password_confirmation => "1234567x")
  user.roles << Role.find_by_name("Admin")
  puts "==============> Setup is complete. You may now use the application. :)"
end