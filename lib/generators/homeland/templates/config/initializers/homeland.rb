# Homeland Config
Homeland.configure do
  # Markup type, [:markdown, :plain, :html], defualt: :markdown
  # self.markup = :markdown

  # App Name
  # self.app_name = 'Homeland'

  # Page Size
  # self.per_page = 32

  # Class name of you User model, default: 'User'
  # self.user_class = 'User'

  # Method of user name in User model, default: 'name'
  # self.user_name_method = 'name'

  # Method of user avatar in User model, default: nil
  # self.user_avatar_url_method = nil

  # Method of User model for check user do have permission manage Homeland.
  # self.user_admin_method = 'admin?'

  # Method name of user profile page path, in User model, default: 'profile_url'
  # self.user_profile_url_method = 'profile_url'

  # authenticate_user method in your Controller, default: 'authenticate_user!'
  # If you use Devise, authenticate_user! is correct
  # self.authenticate_user_method = 'authenticate_user!'

  # current_user method name in your Controller, default: 'current_user'
  # If you use Devise, current_user is correct
  # self.current_user_method = 'current_user'
end
