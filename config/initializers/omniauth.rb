require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env == "development"
    provider :twitter, "KsCjutsbOgAjyhYPeV7w2A", "L3biMPeUjwfH8E7diJrhW78DaZ2QW3XOlJBQ8fGKc"
    provider :github, '31f5dbe1baec4e3ae9bc', 'c017d57f03a99100bb381d6d8dac87913d331625'
    provider :douban, '0dbb51d22a69b10b2931f5767f3d1321','389060b10dfaaf79'
  else
    provider :twitter, "IUBLAMCPpuwhDA91kCTndw", "5ZajNTRzI1KWTdbG3TuH1NyvbqG7wnPp7NhYJB6qmlU"
    provider :github, '6cdd69717d7648e56110', 'dab5745aed84eaa2e03deb6a16da18fb825d228b'
    provider :douban, '0afe615f5a536d9820fb241e0efa48c8','b5ca6ad8f437cfcf'
  end
end