require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "development"
    provider :twitter, "KsCjutsbOgAjyhYPeV7w2A", "L3biMPeUjwfH8E7diJrhW78DaZ2QW3XOlJBQ8fGKc"
    provider :github, '31f5dbe1baec4e3ae9bc', 'c017d57f03a99100bb381d6d8dac87913d331625'
    provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :name => 'google'
  else
    provider :twitter, "IUBLAMCPpuwhDA91kCTndw", "5ZajNTRzI1KWTdbG3TuH1NyvbqG7wnPp7NhYJB6qmlU"
    provider :github, '6cdd69717d7648e56110', 'dab5745aed84eaa2e03deb6a16da18fb825d228b'
    provider :google_apps, OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :domain => 'gmail'
  end
end