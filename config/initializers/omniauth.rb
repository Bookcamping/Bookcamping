Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, 'uUYLczFcet3Wopg3N6RGA', 'd77GrnYHiQrVDm60zBVquidH2BX7EinyO2NltkhY'
end

